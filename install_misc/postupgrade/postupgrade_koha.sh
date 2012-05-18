os=$(uname)

if [ "$os" = "Linux" ]; then
    myshell=$(ps -o "%c" -p $$ 2>/dev/null | tail -1)
else
    myshell=$(ps -o "comm" -p $$ | tail -1)
fi
test -z "$myshell" && myshell=$(basename $SHELL)


my_name=$(basename $0)



red=''
RED=''
green=''
GREEN=''
yellow=''
YELLOW=''
blue=''
BLUE=''
NC=''

if [ "$myshell" = "sh" ]; then
    red='\033[31m'
    RED='\033[31m'
    green='\033[32m'
    GREEN='\033[32m'
    yellow='\033[33m'
    YELLOW='\033[33m'
    blue='\033[34m'
    BLUE='\033[34m'
    NC='\033[0m'
else
    red='\e[0;31m'
    RED='\e[1;31m'
    green='\e[0;32m'
    GREEN='\e[1;32m'
    yellow='\e[0;33m'
    YELLOW='\e[1;33m'
    blue='\e[0;34m'
    BLUE='\e[1;34m'
    NC='\e[0m'
fi


chomp()
{
    local char=${2:-$'\n'}
    eval "$1=\${${1}%$char}"
}

flush_stdin()
{
    stty min 0 time 1 -icanon
    while [ -n "$(dd bs=1 count=1 2>/dev/null)" ]
    do
        continue
    done
    stty min 1 time 0 icanon
}

message_sub()
{
    MESSAGE=$1
    
    if [ "$myshell" = "sh" ]; then
        printf "$MESSAGE"
        echo ""
    else
        echo -e $MESSAGE
    fi
}


help=0
file_conf=""
file_actions_xml=""
file_actions_txt=""
file_actions_xsl=""
file_actions_xsd=""
verbose=0
version_param=""
language="en"
file_lock="postupgrade_koha.lock"
dir_source_postupgrade=""
debug=0
kill_timeout_read=0
timeout_read=60
postupgrade_koha_literal_answer_true_yes=""

clean_up ()
{
    stty echo
    test $debug -eq 1 && echo "Cleaning up"
    test -n "$file_actions_txt" -a -w "$file_actions_txt" && rm $file_actions_txt
    test -f "$file_lock" && rm $file_lock
    local CPIDS="$(pgrep -P $$ 2>/dev/null)"
    (test -n "$CPIDS" && sleep 1 && kill -15 $CPIDS 2>/dev/null &);
    wait
}


help_sub()
{
    message_sub "${BLUE}Use: "$my_name": [-f file_actions_xsd] [-f file_configuration_Koha] [-h] [-n language] [-n version] [-t file_actions_txt] [-s file_actions_xsl] [-v] [-x file_actions_xml]${NC}" >&2
    clean_up
    exit 2
}

####
# Printamos message_subs de error y salimos
####

message_sub_error ()
{
    MESSAGE=$1
    echo " "
    tput bold; message_sub "$MESSAGE" 1>&2
    tput sgr0
    clean_up
    exit 1
}


####
# Exit not forced
####


exit_sub ()
{
    set -- /dev/stdin
    local answer_str=""
    answer_str_yes=${postupgrade_koha_literal_answer_true_yes:="y"}
    stty echo
    until [ "$answer_str" = "$answer_str_yes" -o "$answer_str" = "n" ];
    do
        echo ""
        message_sub "${YELLOW}$postupgrade_koha_literal_exit ($answer_str_yes/n)? [$answer_str_yes]${NC}"
        flush_stdin
        read answer_str
        answer_str=${answer_str:="$answer_str_yes"}
    done
    if [ "$answer_str" = "$answer_str_yes" ]; then
        clean_up
        exit 0
    fi
}


trap exit_sub 2 3
trap clean_up 15
trap "kill_timeout_read=1; exit_sub" 30


####
# Recoger argumentos del script
####

test $# -eq 0 && help_sub

while [ -n "$*" ];
do
    case $1 in
        "-d" )
            shift
            file_actions_xsd=$1
            ;;
        "-f" )
            shift
            file_conf=$1
            ;;
        "-g" )
            debug=1
            ;;
        "-l" )
            shift
            language=$1
            ;;
        "-n" )
            shift
            version_param=$1
            ;;
        "-s" )
            shift
            file_actions_xsl=$1
            ;;
        "-t" )
            shift
            file_actions_txt=$1
            ;;
        "-x" )
            shift
            file_actions_xml=$1
            ;;
        "-v" )
            verbose=1
            ;;
        "-h" | "?" )
            help_sub
            ;;
        * )
            help_sub
            ;;
    esac
    shift
done


dir_source_postupgrade=$(test -n "$file_actions_txt" -a -f "$file_actions_txt" && dirname $file_actions_txt)
test -z "$dir_source_postupgrade" && dir_source_postupgrade=$(test -n "$file_actions_xml" -a -f "$file_actions_xml" && dirname $file_actions_xml)
test -z "$dir_source_postupgrade" -o ! -d "$dir_source_postupgrade" && message_sub_error "${RED}Couldn't get the source dir${NC}"
test -z "$file_actions_txt" -a ! -w "$dir_source_postupgrade" && message_sub_error "${RED}Source dir $dir_source_postupgrade not writeable${NC}"
test $debug -eq 1 && message_sub "dir_source_postupgrade: $dir_source_postupgrade"

file_lock=$dir_source_postupgrade"/"$file_lock

file_locale=$(test -n "$language" && echo $dir_source_postupgrade"/locale_postupgrade_koha_"$language".sh")
test -z "$file_locale" -o ! -r "$file_locale" && file_locale=$dir_source_postupgrade"/locale_postupgrade_koha_en.sh"
source $file_locale 2>/dev/null || . $file_locale
test -z "$postupgrade_koha_literal_init" && message_sub_error "${RED}Couldn't load locale file${NC}"

message_sub "${GREEN}$postupgrade_koha_literal_init${NC}"
echo ""

if [ -f $file_lock ]; then
    process=$(ps -ef | grep -m 1 "$my_name" | awk -F " " '{print $2}')
    if [ -n "$process" -a "$process" = $(cat $file_lock) ]; then
        message_sub "${RED}$postupgrade_koha_literal_process_already_info${NC}" >&2
        exit 1
    else
        echo $$ > $file_lock
    fi
else
    echo $$ > $file_lock
fi

for app in $(echo "bzip2 gzip openssl"); do
    test $debug -eq 1 && message_sub "$postupgrade_koha_literal_check_app_info $app${NC}"
    app_path=$(which $app 2>/dev/null) || message_sub_error "${RED}$postupgrade_koha_literal_miss_app_error $app${NC}"
done
app="mcrypt"
test $debug -eq 1 && message_sub "$postupgrade_koha_literal_check_app_info $app${NC}"
if [ -z "$app_path" ]; then
    test $verbose -eq 1 && message_sub "${RED}$postupgrade_koha_literal_miss_app_info $app${NC}"
fi

app="xmllint"
test $debug -eq 1 && message_sub "$postupgrade_koha_literal_check_app_info $app${NC}"
app_path=$(which $app 2>/dev/null)
if [ -z "$app_path" ]; then
    test $debug -eq 1 && message_sub "$postupgrade_koha_literal_check_app_info perl lib XML::LibXML${NC}"
    perl -e 'require XML::LibXML;' 2>/dev/null || message_sub_error "${RED}$postupgrade_koha_literal_miss_app_error perl lib XML::LibXML${NC}"
fi
app="xsltproc"
test $debug -eq 1 && message_sub "$postupgrade_koha_literal_check_app_info $app${NC}"
app_path=$(which $app 2>/dev/null)
if [ -z "$app_path" ]; then
    test $debug -eq 1 && message_sub "$postupgrade_koha_literal_check_app_info perl lib XML::LibXSLT${NC}"
    perl -e 'require XML::LibXSLT;' 2>/dev/null || message_sub_error "${RED}$postupgrade_koha_literal_miss_app_error perl lib XML::LibXSLT${NC}"
fi


test $verbose -eq 1 && message_sub "${YELLOW}$postupgrade_koha_literal_check_file_conf_info${NC}"
test -n "$file_conf" && test ! -r "$file_conf" && message_sub_error "${RED}$postupgrade_koha_literal_check_file_conf_not_read_error${NC}"
test -z "$file_conf" -a -n "$KOHA_CONF" && test ! -r "$KOHA_CONF" && message_sub_error "${RED}$postupgrade_koha_literal_check_koha_conf_not_read_error${NC}"
test -z "$file_conf" && file_conf="$KOHA_CONF"
test -n "$version_param" && echo "$version_param" | egrep -q "^[[:digit:]]+\.[[:digit:]]+(\.[[:digit:]]+)?$" && test $? -ne 0 && message_sub_error "${RED}$postupgrade_koha_literal_version_bad_error e.g.: 1.8.1${NC}"

test $verbose -eq 1 && message_sub "${YELLOW}$postupgrade_koha_literal_reading_file_conf_info $file_conf${NC}"
node_config=0
node_config_db_scheme=""
node_config_database=""
node_config_hostname=""
node_config_port=""
node_config_user=""
node_config_pass=""
node_intranetdir=""
node_install_log=""
while read line;
do
    echo $line | grep -q "<config>" && node_config=1 && continue
    test $node_config -eq 1 && echo $line | grep -q "</config>" && node_config=0 && break
    if [ $node_config -eq 1 ]; then
        case $line in
            *db_scheme* )
                node_config_db_scheme=$(echo $line | sed -r 's#<db_scheme>(.+)</db_scheme>#\1#')
                ;;
            *database* )
                node_config_database=$(echo $line | sed -r 's#<database>(.+)</database>#\1#')
                ;;
            *hostname* )
                node_config_hostname=$(echo $line | sed -r 's#<hostname>(.+)</hostname>#\1#')
                ;;
            *port* )
                node_config_port=$(echo $line | sed -r 's#<port>(.+)</port>#\1#')
                ;;
            *user* )
                node_config_user=$(echo $line | sed -r 's#<user>(.+)</user>#\1#')
                ;;
            *pass* )
                node_config_pass=$(echo $line | sed -r 's#<pass>(.+)</pass>#\1#')
                ;;
            *intranetdir* )
                node_intranetdir=$(echo $line | sed -r 's#<intranetdir>(.+)</intranetdir>#\1#')
                ;;
            *install_log* )
                node_install_log=$(echo $line | sed -r 's#<install_log>(.+)</install_log>#\1#')
                ;;
            * )
                ;;
        esac
    fi
done < "$file_conf"

if [ $debug -eq 0 ]; then
    test -z "$node_config_user" -o -z "$node_config_pass" && message_sub_error "${RED}$postupgrade_koha_literal_not_exists_user_pass_bbdd_error${NC}"
    message_sub "${YELLOW}$postupgrade_koha_literal_ask_user_pass_bbdd_info${NC}"
    while [ 1 ]; do
        answer_str=""
        until [ -n "$answer_str" ]; do
            message_sub "${YELLOW}$postupgrade_koha_literal_check_user_bbdd_info${NC}"
            flush_stdin
            (ppid=$(cat $file_lock); sleep $timeout_read && kill -30 $ppid 2>/dev/null || kill -30 $(ps -p $$ -o ppid=) 2>/dev/null) &
            read answer_str
            kill -15 %+ 2>/dev/null || kill -15 $! 2>/dev/null
        done
        test "$answer_str" = "$node_config_user" && break
        if [ $kill_timeout_read -eq 0 ]; then
            answer_str=""
            until [ -n "$answer_str" ]; do
                flush_stdin
                message_sub "${YELLOW}$postupgrade_koha_literal_exit ($postupgrade_koha_literal_answer_true_yes/n)${NC}"
                read answer_str
            done
            test "$answer_str" = "$postupgrade_koha_literal_answer_true_yes" && clean_up && exit 0
        else
            kill_timeout_read=0
        fi
    done
    while [ 1 ]; do
        answer_str=""
        stty_orig=`stty -g`
        stty -echo
        until [ -n "$answer_str" ]; do
            message_sub "${YELLOW}$postupgrade_koha_literal_check_pass_bbdd_info${NC}"
            flush_stdin
            (ppid=$(cat $file_lock); sleep $timeout_read && kill -30 $ppid 2>/dev/null || kill -30 $(ps -p $$ -o ppid=) 2>/dev/null) &
            read answer_str
            kill -15 %+ 2>/dev/null || kill -15 $! 2>/dev/null
        done
        stty echo
        test "$answer_str" = "$node_config_pass" && break
        if [ $kill_timeout_read -eq 0 ]; then
            answer_str=""
            until [ -n "$answer_str" ]; do
                flush_stdin
                message_sub "${YELLOW}$postupgrade_koha_literal_exit ($postupgrade_koha_literal_answer_true_yes/n)${NC}"
                read answer_str
            done
            test "$answer_str" = "$postupgrade_koha_literal_answer_true_yes" && clean_up && exit 0
        else
            kill_timeout_read=0
        fi
    done
fi


test -z "$node_install_log" -o ! -r "$node_install_log" && message_sub_error "${RED}$postupgrade_koha_literal_not_exists_file_log_error${NC}"
install_base=$(grep INSTALL_BASE $node_install_log | sed -r 's#INSTALL_BASE=(.+)#\1#')
test $verbose -eq 1 && message_sub "${YELLOW}$postupgrade_koha_literal_dir_installation_info $install_base${NC}"
test -r "$install_base" || message_sub_error "${RED}$postupgrade_koha_literal_dir_installation_not_access_error${NC}"

test $verbose -eq 1 && message_sub "${YELLOW}$postupgrade_koha_literal_check_conex_bbdd_info $node_config_db_scheme${NC}"
if [ "$node_config_db_scheme" = "Pg" ]; then
    psqlcmd=$(which psql)
    bbddconex="$psqlcmd -h $node_config_hostname -p $node_config_port -U $node_config_user -W -d $node_config_database"
else
    mysqlcmd=$(which mysql)
    bbddconex="$mysqlcmd -h $node_config_hostname -P $node_config_port -u $node_config_user -p$node_config_pass $node_config_database"
fi
echo "quit" | $bbddconex || message_sub_error "${RED}$postupgrade_koha_literal_bad_conex_bbdd_error $node_config_db_scheme $bbddconex ${NC}"


test $verbose -eq 1 && message_sub "${YELLOW}$postupgrade_koha_literal_check_file_actions_info${NC}"
if [ -n "$file_actions_xml" -a -r "$file_actions_xml" -a -n "$file_actions_xsl" -a -r "$file_actions_xsl" -a -n "$file_actions_xsd" -a -r "$file_actions_xsd" ]; then
    validated=0
    xmllintcmd=$(which xmllint 2>/dev/null)
    if [ -n "$xmllintcmd" -a -x "$xmllintcmd" ]; then
        test $verbose -eq 1 && message_sub "${YELLOW}$postupgrade_koha_literal_validate_file_actions_info $xmllintcmd${NC}"
        $xmllintcmd --schema $file_actions_xsd $file_actions_xml >/dev/null 2>&1
        test $? -eq 0 && validated=1
    else
        test $verbose -eq 1 && message_sub "${YELLOW}$postupgrade_koha_literal_validate_file_actions_info perl${NC}"
        perlxslcmd='use XML::LibXML; my $doc = XML::LibXML->load_xml(location => "'$file_actions_xml'"); my $xmlschema = XML::LibXML::Schema->new(location => "'$file_actions_xsd'"); $xmlschema->validate( $doc );'
        typeset -x PERLXSDCMD="$perlxslcmd" 2>/dev/null || export PERLXSDCMD="$perlxslcmd"
        test $debug -eq 1 && echo "$PERLXSDCMD"
        perl -e 'eval $ENV{"PERLXSDCMD"}; if ($@) {exit(1);} else { exit(0);}'
        test $? -eq 0 && validated=1
        unset PERLXSDCMD
    fi
    test $validated -eq 0 && message_sub_error "${RED}$postupgrade_koha_literal_validate_file_actions_error${NC}"

    langxsl=$(egrep '<xsl:variable name="language">.+</xsl:variable>' $file_actions_xsl | sed -r 's#<xsl:variable name="language">(.+)</xsl:variable>#\1#')
    if [ -z "$langxsl" -o "$langxsl" != "$language" ]; then
        sed -r "s#<xsl:variable name=\"language\">.+</xsl:variable>#<xsl:variable name=\"language\">$language</xsl:variable>#" $file_actions_xsl > $dir_source_postupgrade"/tmp_xsl" && mv $dir_source_postupgrade"/tmp_xsl" $file_actions_xsl
        if [ $? -eq 1 ]; then
            test -w $dir_source_postupgrade"/tmp_xsl" && rm -f $dir_source_postupgrade"/tmp_xsl" 2>/dev/null
            message_sub_error "${RED}$postupgrade_koha_literal_change_lang_xsl_error${NC}"
        else
            test $verbose -eq 1 && message_sub "${YELLOW}$postupgrade_koha_literal_changed_lang_xsl_info${NC}"
        fi
    fi
    transformed=0
    xsltproccmd=$(which xsltproc 2>/dev/null)
    if [ -n "$xsltproccmd" -a -x "$xsltproccmd" ]; then
        test $verbose -eq 1 && message_sub "${YELLOW}$postupgrade_koha_literal_creating_file_actions_info $xsltproccmd${NC}"
        $xsltproccmd -o $dir_source_postupgrade"/postupgrade_koha_actions.txt" $file_actions_xsl $file_actions_xml 2>/dev/null
        if [ $? -eq 0 ]; then
            test -r $dir_source_postupgrade"/postupgrade_koha_actions.txt" && transformed=1 && file_actions_txt=$dir_source_postupgrade"/postupgrade_koha_actions.txt"
        fi
    fi
    if [ $transformed -eq 0 ]; then
        test $verbose -eq 1 && message_sub "${YELLOW}$postupgrade_koha_literal_creating_file_actions_info perl${NC}"
        perlxslcmd='use XML::LibXSLT; use XML::LibXML; my $source = XML::LibXML->load_xml(location => "'$file_actions_xml'"); my $xslt = XML::LibXSLT->new(); my $style_doc = XML::LibXML->load_xml(location=>"'$file_actions_xsl'", no_cdata=>1);  my $stylesheet = $xslt->parse_stylesheet($style_doc); my $results = $stylesheet->transform($source); $stylesheet->output_file($results, "'$dir_source_postupgrade'/postupgrade_koha_actions.txt");'
        typeset -x PERLXSLCMD="$perlxslcmd" 2>/dev/null || export PERLXSLCMD="$perlxslcmd"
        perl -e 'eval $ENV{"PERLXSLCMD"}; if ($@) {exit(1);} else { exit(0);}'
        if [ $? -eq 1 ]; then
            test $debug -eq 1 && echo "$PERLXSLCMD" && ls -la $dir_source_postupgrade"/postupgrade_koha_actions.txt"
            unset PERLXSLCMD
            message_sub_error "${RED}$postupgrade_koha_literal_transf_file_actions_error${NC}"
        else
            unset PERLXSLCMD
            file_actions_txt=$dir_source_postupgrade"/postupgrade_koha_actions.txt"
        fi
    fi
fi
test -z "$file_actions_txt" -o ! -r "$file_actions_txt" && message_sub_error "${RED}$postupgrade_koha_literal_not_reading_file_actions_error $file_actions_txt${NC}"

kobliversion=""
test -n "$version_param" && kobliversion="$version_param"
if [ -z "$kobliversion" ]; then
    VERSION_KOBLI="1.8.1"
    ficherokohaversion=$node_intranetdir"/kohaversion.pl"
    if [ -r "$filekohaversion" ]; then
        kobliversion=$(egrep "VERSIONKOBLI[[:space:]]*=[[:space:]]*['\"][[:digit:]]+" $filekohaversion | sed -r -e 's/.+'\''(.+)'\''\s*;/\1/')
    else
        message_sub "${YELLOW}$postupgrade_koha_literal_not_reading_file_version_info $filekohaversion${NC}"
        kobliversion=$(echo "SELECT value FROM systempreferences WHERE variable='VersionKobli'" | $bbddconex | awk '{split($0, a, "\n")} END{print a[1]}')
    fi
fi
test -z "$kobliversion" && kobliversion="$VERSION_KOBLI"
test $verbose -eq 1 && message_sub "${YELLOW}$postupgrade_koha_literal_version_info $kobliversion${NC}"

test $verbose -eq 1 && message_sub "${YELLOW}$postupgrade_koha_literal_process_file_actions_info${NC}" && echo ""


####
# Procesar actions
####

compare_version()
{
    local current_version="$1"
    local version_action="$2"
    local ret=$(echo "$current_version;$version_action" | awk '{
        split($0, a, ";")
        bl=split(a[1], b, "\.")
        cl=split(a[2], c, "\.")
        min=bl < cl?bl:cl
        ret=0
        for (i = 1; i <= min; i++) {
            if (c[i] < b[i]) {
                ret = -1
                break
            } else {
                if (c[i] > b[i]) {
                    ret = 1
                    break
                }
            }
        }
        }
        END { print ret;}
    ')
    echo $ret
}


decode_action_compress()
{
    local action_param="$1"
    local compress_type="$2"
    local action=""
    local compress_cmd=""
    
    local openssl_cmd=$(which openssl 2>/dev/null)
    case $compress_type in
        *bzip2* )
            compress_cmd=$(which bzip2 2>/dev/null)
            ;;
        *gzip* )
            compress_cmd=$(which gzip 2>/dev/null)
            ;;
        * )
        ;;
    esac
    test -n "$openssl_cmd" -a -n "$compress_cmd" && action=$(echo "$action_param" | $openssl_cmd enc -d -base64 2>/dev/null | $compress_cmd -d -c -f 2>/dev/null)
    test $debug -eq 1 && echo "$compress_type $compress_cmd $openssl_cmd #$action_param# $action" >&2
    echo "$action"
}


decode_action_crypt()
{
    local action_param="$1"
    local crypt_type="$2"
    local password="$3"
    local action=""
    
    local crypt_cmd=$(which openssl 2>/dev/null)
    local openssl_cmd="$crypt_cmd"
    if [ -n "$password" ]; then
        test -n "$crypt_cmd" && action=$(echo "$action_param" | $openssl_cmd enc -d -base64 2>/dev/null | $crypt_cmd enc -d -"$crypt_type" -pass pass:"$password" 2>/dev/null)
        if [ $? -ne 0 ]; then
            crypt_cmd=$(which mcrypt 2>/dev/null)
            test -n "$crypt_cmd" && action=$(echo "$action_param" | $openssl_cmd enc -d -base64 2>/dev/null | $crypt_cmd -d -a $crypt_type -q -k "$password" 2>/dev/null)
        fi
    fi
    test $debug -eq 1 && echo "$crypt_type $crypt_pass $crypt_cmd #$action_param# " >&2
    echo "$action"
}


decode_action_base64()
{
    local action_param="$1"
    local action=""
    
    local openssl_cmd=$(which openssl 2>/dev/null)
    local base64_cmd=$(which base64 2>/dev/null)
    if [ -n "$openssl_cmd" -a -x "$openssl_cmd" ]; then
        action=$(echo "$action_param" | $openssl_cmd enc -d -base64 2>/dev/null)
    fi
    if [ -z "$action" ]; then
        if [ -n "$base64_cmd" -a -x "$base64_cmd" ]; then
            action=$(echo "$action_param" | $base64_cmd enc -d 2>/dev/null)
        else
            perlbase64cmd='use MIME::Base64; $decoded = decode_base64("'$action_param'");'
            typeset -x PERLBASE64CMD="$perlbase64cmd" 2>/dev/null || export PERLBASE64CMD="$perlbase64cmd"
            action=$(perl -e 'my $decoded = ""; eval $ENV{"PERLBASE64CMD"}; print $decoded;' 2>/dev/null)
            unset PERLBASE64CMD
        fi
    fi
    test $debug -eq 1 && echo "#$action_param# $action" >&2
    echo "$action"
}


decode_action ()
{
    local action_param="$1"
    local action_compress="$2"
    local action_crypt="$3"
    local action_base64="$4"
    local action_md5="$5"
    local action=""
    local action_aux="$action_param"
    
    if [ -n "$action_compress" -a "$action_compress" != "-" ]; then
        action=$(decode_action_compress "$action_aux" "$action_compress")
    elif [ -n "$action_crypt" -a "$action_crypt" != "-" ]; then
        local crypt_type=$(echo "$action_crypt" | cut -d : -f2)
        local crypt_pass=$(echo "$action_crypt" | cut -d : -f3)
        action=$(decode_action_crypt "$action_aux" "$crypt_type" "$crypt_pass")
    elif [ "$action_base64" = "true" ]; then
        action=$(decode_action_base64 "$action_aux")
    else
        action="$action_aux"
    fi
    if [ -n "$action_md5" -a "$action_md5" != "-" ]; then
        local md5_action_calc=""
        local md5_action_calc_aux=$(echo "$action" | md5sum 2>/dev/null || echo "$action" | md5 2>/dev/null) && md5_action_calc=$(echo "$md5_action_calc_aux" | cut -d " " -f1 2>/dev/null)
        test -z "$md5_action_calc" && openssl_cmd=$(which openssl 2>/dev/null) && test -n "$openssl_cmd" -a -x "$openssl_cmd" && md5_action_calc=$(echo "$action" | $openssl_cmd dgst -md5 2>/dev/null)
        test $debug -eq 1 && echo "#$action_md5#  $md5_action_calc" >&2
        test "$action_md5" != "$md5_action_calc" && action=""
    fi
    echo "$action"
}


action_version=""
action_user=""
action_question=""
action_compress=""
action_crypt=""
action_file=""
action_base64=0
action_md5=""
if [ "$myshell" = "sh" ]; then
    action_answers=""
else
    declare -a action_answers 2>/dev/null || typeset -a action_answers 2>/dev/null
fi
action_action=""
actions=1

process_action()
{
    local version="$1"
    local user="$2"
    local question="$3"
    local action="$4"
    local response_ok="$5"
    local response_nok="$6"
    local action_file="$7"
    local ret=$(compare_version "$kobliversion" "$version")
    if [ $ret -eq -1  ]; then
        return
    fi
    echo -n $actions": "
    echo "$question"
    local answer_str=""
    local answ=""
    local answ_value=""
    local answ_desc=""
    local answstr=""
    if [ "$myshell" = "sh" ]; then
        OLD_IFS=$IFS
        IFS='|'
        i=0
        for answ in $action_answers
        do
            test -z "$answ" && continue
            test $i -ne 0 && answstr="$answstr / "
            answ_value=$(echo "$answ" | cut -d : -f1)
            answ_desc=$(echo "$answ" | sed -r 's#^(true|false):(.+)$#\2#')
            answstr="$answstr$answ_desc"
            if [ "$answ_value" = "true" ]; then answstr=$answstr" ($postupgrade_koha_literal_answer_true_yes) "; else answstr=$answstr" (n) "; fi
            i=$(expr ${i} + 1)
        done
        IFS=$OLD_IFS
    else
        for answ in $(seq 0 $((${#action_answers[@]} - 1))); do
            test $answ -ne 0 && answstr="$answstr / "
            answ_value=$(echo "${action_answers[$answ]}" | cut -d : -f1)
            answ_desc=$(echo "${action_answers[$answ]}" | sed -r 's#^(true|false):(.+)$#\2#')
            answstr="$answstr$answ_desc"
            if [ "$answ_value" = "true" ]; then answstr=$answstr" ($postupgrade_koha_literal_answer_true_yes) "; else answstr=$answstr" (n) "; fi
        done
    fi
    answstr=$answstr": [n]"
    #set -- /dev/stdin
    until [ "$answer_str" = "$postupgrade_koha_literal_answer_true_yes" -o "$answer_str" = "n" ];
    do
        flush_stdin
        echo -n $answstr
        read answer_str
        answer_str=${answer_str:="n"}
    done
    if [ "$answer_str" = "$postupgrade_koha_literal_answer_true_yes" ]; then
        test $verbose -eq 1 && message_sub "${YELLOW}$postupgrade_koha_literal_executing_info${NC}"
        if [ "$user" != "$USER" ]; then
            message_sub "${YELLOW}$postupgrade_koha_literal_distinct_user_info${NC}"
            sudocmd=$(which sudo 2>/dev/null)
            if [ -n "$sudocmd" -a -x "$sudocmd" ]; then
                sudocmd="$sudocmd -u $user $action"
            else
                sudocmd="su -l $user -c \"$action\""
            fi
            eval "$sudocmd"
        else
            if [ -n "$action_file" -a "$action_file" != "-" -a -x "$action_file" ]; then
                . $action_file
            else
                eval "$action"
            fi
        fi
        okaction=$?
        if [ $okaction -ne 0 ]; then
            echo $okaction
            if [ "$response_nok" != "-" ]; then
                message_sub "${RED}$response_nok${NC}"
            else
                message_sub "${RED}$postupgrade_koha_literal_bad_exec_info${NC}"
            fi
            test $verbose -eq 1 && message_sub "${RED}$action${NC}"
        else
            if [ "$response_ok" != "-" ]; then
                message_sub "${GREEN}$response_ok${NC}"
            else
                message_sub "${GREEN}$postupgrade_koha_literal_ok_exec_info${NC}"
            fi
        fi
    fi
    echo ""
}


lines=0
finleer=0
action_version=""
action_user=""
action_question=""
action_action=""
action_compress=""
action_crypt=""
action_file=""
action_base64=0
action_md5=""
action_response_comment_ok=""
action_response_comment_nok=""
while [ $finleer -eq 0 ]; do
    current_lines=0
    command=""
    while read line;
    do
        current_lines=$(expr ${current_lines} + 1)
        test $lines -gt 0 -a $current_lines -le $lines && continue
        echo $line | egrep -q "^[[:space:]]*#" && continue
        case $line in
            *-END-* )
                finleer=1
                break
                ;;
            *------* )
                lines=$current_lines
                break
                ;;
            *Version:* )
                command="Version"
                action_version=$(echo $line | sed -r 's#Version:\s*(.*)$#\1#')
                ;;
            *User:* )
                command="User"
                action_user=$(echo $line | sed -r 's#User:\s*(.*)$#\1#')
                ;;
            *Md5:* )
                command="Md5"
                action_md5=$(echo $line | sed -r 's#Md5:\s*([^\s]*)\s*$#\1#')
                ;;
            *Compress:* )
                command="Compress"
                action_compress=$(echo $line | sed -r 's#Compress:\s*(.*)$#\1#')
                ;;
            *Crypt:* )
                command="Crypt"
                action_crypt=$(echo $line | sed -r 's#Crypt:\s*(.*)$#\1#')
                ;;
            *Base64:* )
                command="Base64"
                action_base64=$(echo $line | sed -r 's#Base64:\s*(.*)$#\1#')
                ;;
            *File:* )
                command="File"
                action_file=$(echo $line | sed -r 's#File:\s*(.*)$#\1#')
                ;;
            *Question:* )
                command="Question"
                action_question=$(echo $line | sed -r 's#Question:\s*(.+)$#\1#')
                ;;
            *Answer:* )
                command="Answer"
                action_answer=$(echo $line | sed -r 's#Answer:\s*(.+)$#\1#')
                if [ "$myshell" = "sh" ]; then
                    action_answers=$action_answers"|"$action_answer
                else
                    action_answers[${#action_answers[*]}]="$action_answer"
                fi
                ;;
            *Response_Comment_ok:* )
                command="Response_Comment_ok"
                action_response_comment_ok=$(echo $line | sed -r 's#Response_Comment_ok:\s*(.+)$#\1#')
                ;;
            *Response_Comment_nok:* )
                command="Response_Comment_nok"
                action_response_comment_nok=$(echo $line | sed -r 's#Response_Comment_nok:\s*(.+)$#\1#')
                ;;
            *Action:* )
                command="Action"
                action_action=$(echo $line | sed -r 's#Action:\s*(.+)$#\1#')
                ;;
            * )
                if [ "$command" = "Action" ]; then
                    if [ "$myshell" = "sh" ]; then
                        echo "$line" | egrep -q "[^[:blank:][:cntrl:]]+" && action_action=$action_action'\n'"$line"
                    else
                        echo "$line" | egrep -q "[^[:blank:][:cntrl:]]+" && action_action=$action_action$'\n'"$line"
                    fi
                fi
                ;;
        esac
    done < "$file_actions_txt"

    if [ -n "$action_action" ]; then
        test -z "$action_compress" && action_compress="-"
        test -z "$action_crypt" && action_crypt="-"
        test -z "$action_file" && action_file="-"
        test -z "$action_md5" && action_md5="-"
        test -z "$action_base64" && action_base64="-"
        action_parsed=$(decode_action "$action_action" "$action_compress" "$action_crypt" $action_base64 "$action_md5")
        test -z "$action_user" && action_user="$USER"
        test -z "$action_version" && action_version="$kobliversion"
        test -z "$action_response_comment_ok" && action_response_comment_ok="-"
        test -z "$action_response_comment_nok" && action_response_comment_nok="-"
        test "$myshell" = "sh" && action_answers=$action_answers"|"
        test $debug -eq 1 && echo "action: #$action_parsed#"
        test -n "$action_parsed" && process_action "$action_version" "$action_user" "$action_question" "$action_parsed" "$action_response_comment_ok" "$action_response_comment_nok" "$action_file"
        action_parsed=""
        action_version=""
        action_user=""
        action_question=""
        action_compress=""
        action_crypt=""
        action_file=""
        action_base64=0
        action_md5=""
        unset action_answers
        if [ "$myshell" = "sh" ]; then
            action_answers=""
        else
            declare -a action_answers 2>/dev/null || typeset -a action_answers 2>/dev/null
        fi
        action_action=""
        actions=$(expr ${actions} + 1)
    fi
done

clean_up
exit 0

