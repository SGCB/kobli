package C4::Serial_to_Holding;

use strict;
use MARC::Record;
use MARC::Field;

sub map{  #función principal

  my $dbh = $_[1];    #recibo la conexión a la base de datos
  my $record = $_[2]; #recibo el registro con los serials
  my $biblionumber = $_[3]; #recibo el biblionumber del registro en la bd
  my $marc = MARC::Record->new_from_usmarc();

  #LEADER
  our ($c00,$c01,$c02,$c03,$c04,$c05,$c06,$c07,$c08,$c09,$c10,$c11,$c12,$c13,$c14,$c15,$c16,$c17,$c18,$c19,$c20,$c21,$c22,$c23);

  $c00 = " ";
  $c01 = " ";
  $c02 = " ";
  $c03 = " ";
  $c04 = " ";
  $c05 = "n";
  $c06 = "y";
  $c07 = "#";
  $c08 = "#";
  $c09 = "a";
  $c10 = "2";
  $c11 = "2";
  $c12 = "y";
  $c13 = " ";
  $c14 = " ";
  $c15 = " ";
  $c16 = " ";
  $c17 = "3";
  $c18 = "i";
  $c19 = "#";
  $c20 = "4";
  $c21 = "5";
  $c22 = "0";
  $c23 = "0";

  $marc->leader($c00.$c01.$c02.$c03.$c04.$c05.$c06.$c07.$c08.$c09.$c10.$c11.$c12.$c13.$c14.$c15.$c16.$c17.$c18.$c19.$c20.$c21.$c22.$c23);

  #001
  my $query = "SELECT subscriptionid FROM subscription WHERE biblionumber = ?";
  my $sth = $dbh->prepare($query);
  $sth->execute($biblionumber);
  my $data = $sth->fetchrow_hashref();
  my $subscriptionid = $data->{'subscriptionid'}; 
  my $field = MARC::Field->new('001', $subscriptionid);	
  $marc->insert_grouped_field($field);
  
  #003
  $query = "SELECT branchcode FROM subscription WHERE subscriptionid = ?";
  $sth = $dbh->prepare($query);
  $sth->execute($subscriptionid);
  $data = $sth->fetchrow_hashref();
  $field = MARC::Field->new('003', $data->{'branchcode'});	
  $marc->insert_grouped_field($field);
  
  #004
  if($record->field('001')){
    $field = MARC::Field->new('004', $record->field('001'));	
  }else{
    $field = MARC::Field->new('001', $biblionumber);
    $record->insert_fields_ordered($field);
    $field = MARC::Field->new('004', $biblionumber);
  }
  $marc->insert_grouped_field($field);
  
  #005
  $query = "SELECT datecreated FROM biblio WHERE biblionumber = ?";
  $sth = $dbh->prepare($query);
  $sth->execute($biblionumber);
  $data = $sth->fetchrow_hashref();
  my $dat = $data->{'datecreated'}; 
  $dat =~ s/-//g;
  $field = MARC::Field->new('005', $dat);	
  $marc->insert_grouped_field($field);
  
  #008
  $query = "SELECT startdate FROM subscription WHERE subscriptionid = ?";
  $sth = $dbh->prepare($query);
  $sth->execute($subscriptionid);
  $data = $sth->fetchrow_hashref();
  my $c00_05 = $data->{'startdate'}; 
  $c00_05 =~ s/\d{2}//;
  $c00_05 =~ s/-//g;
  $c06 = "4";
  $c07 = "u";
  $query = "SELECT enddate FROM subscription WHERE subscriptionid = ?";
  $sth = $dbh->prepare($query);
  $sth->execute($subscriptionid);
  $data = $sth->fetchrow_hashref();
  my $c08_11 = $data->{'enddate'};
  $c08_11 =~ s/\d{2}//;
  $c08_11 =~ s/\d{2}$//;
  $c08_11 =~ s/-//g;
  $c12 = "0";
  $c13 = "#";
  $c14 = "#";
  $c15 = "#";
  $c16 = "4";
  $query = "SELECT COUNT(*) as subs FROM serial WHERE subscriptionid = ?";
  $sth = $dbh->prepare($query);
  $sth->execute($subscriptionid);
  $data = $sth->fetchrow_hashref();
  my $c17_19 = $data->{'subs'};
  if($c17_19/10 == 0){
    $c17_19 = "00".$c17_19;
  }elsif($c17_19/100 == 0){
    $c17_19 = "0".$c17_19;
  }
  $c20 = "u";
  $c21 = "u";
  my $c22_24 = "###";
  my $c25 = "0";
  my $c26_31 = join" ",(split" ",(qx(ls --full-time -rt))[-1])[5];
  $c26_31 =~ s/\d{2}//;
  $c26_31 =~ s/-//g;
  $field = MARC::Field->new('008', $c00_05.$c06.$c07.$c08_11.$c12.$c13.$c14.$c15.$c16.$c17_19.$c20.$c21.$c22_24.$c25.$c26_31);	
  $marc->insert_grouped_field($field);
  
  #852
  my @c8 = $record->field('852');
  for(my $i=0; $c8[$i]; $i++){
    $marc->insert_grouped_field($c8[$i]);
    $record->delete_field($c8[$i]);
  }  
  
  #853
  
  $query = "SELECT numberingmethod FROM subscription WHERE subscriptionid = ?";
  $sth = $dbh->prepare($query);
  $sth->execute($subscriptionid);
  $data = $sth->fetchrow_hashref();
  $dat = $data->{'numberingmethod'};
  $dat =~ s/,//g;
  my @serial = split(/\s+/, $dat);
  my $a = $serial[0];
  my $b = $serial[1];
  my $c = $serial[2];
  my $d = $serial[3];
  my $e = $serial[4];
  my $f = $serial[5];
  $field = MARC::Field->new('853', '2', '2' , 'a' => $a, 'b' => $b, 'c' => $c, 'd' => $d, 'e' => $e, 'f' => $f );	
  $marc->insert_grouped_field($field);
  
  $query = "SELECT whenmorethan1 FROM subscription WHERE subscriptionid = ?";
  $sth = $dbh->prepare($query);
  $sth->execute($subscriptionid);
  $data = $sth->fetchrow_hashref();
  $dat = $data->{'whenmorethan1'};
  if($dat<9999999){
     $field->add_subfields( 'v' => 'r' );
  }else{
    $field->add_subfields( 'v' => 'c' );
  }
  
  $query = "SELECT periodicity FROM subscription WHERE subscriptionid = ?";
  $sth = $dbh->prepare($query);
  $sth->execute($subscriptionid);
  $data = $sth->fetchrow_hashref();
  $dat = $data->{'periodicity'};
  my $w="";
  
  if($dat==1){
    $w = 'd';
  }elsif($dat==2){
    $w = 'w';
  }elsif($dat==3){
    $w = 's';
  }elsif($dat==4){
    $w = 's';
  }elsif($dat==5){
    $w = 'm';
  }elsif($dat==6){
    $w = 'b';
  }elsif($dat==7){
    $w = 'q';
  }elsif($dat==8){
    $w = 't';
  }elsif($dat==9){
    $w = 'f';
  }elsif($dat==10){
    $w = 'a';
  }elsif($dat==11){
    $w = 'g';
  }elsif($dat==12){
    $w = 'd';
    $field->add_subfields( 'p' => '2' );
  }elsif($dat==13){
    $w = 'i';
  }else{
    $w = 'x';
  }
  # 1=d diario
  # 2=w semanal
  # 3=s semimensual
  # 4=s semimensual
  # 5=m mensual
  # 6=b bimestral
  # 7=q trimestral
  # 8=t tres veces al año
  # 9=f semestral
  # 10=a anual
  # 11=g bienal
  # 12=diario $p=2
  # 13=i 3 a la semana
  $field->add_subfields( 'w' => $w );
  
  $field->add_subfields( '8' => '1' );
  
  #863
  $query = "SELECT serialseq FROM serial WHERE subscriptionid = ?";
  $sth = $dbh->prepare($query);
  $sth->execute($subscriptionid);
  $data = $sth->fetchrow_hashref();
  $dat = $data->{'serialseq'};
  for(my $x=1; $dat; $x++){
      $dat =~ s/,//g;
    @serial = split(/\s+/, $dat);
    $a = $serial[0];
    $b = $serial[1];
    $c = $serial[2];
    $d = $serial[3];
    $e = $serial[4];
    $f = $serial[5];
    $field = MARC::Field->new('863', '3', '3' ,'8' => '1.'.$x, 'a' => $a, 'b' => $b, 'c' => $c, 'd' => $d, 'e' => $e, 'f' => $f );	
    $marc->insert_grouped_field($field);
    $data = $sth->fetchrow_hashref();
    $dat = $data->{'serialseq'};
  }
  
    #876
  my @c8 = $record->field('876');
  for(my $i=0; $c8[$i]; $i++){
    $marc->insert_grouped_field($c8[$i]);
    $record->delete_field($c8[$i]);
  } 
  
    #877
  my @c8 = $record->field('877');
  for(my $i=0; $c8[$i]; $i++){
    $marc->insert_grouped_field($c8[$i]);
    $record->delete_field($c8[$i]);
  } 
  
    #878
  my @c8 = $record->field('878');
  for(my $i=0; $c8[$i]; $i++){
    $marc->insert_grouped_field($c8[$i]);
    $record->delete_field($c8[$i]);
  } 

  return $marc;
}
	return 1;	#devuelvo verdadero