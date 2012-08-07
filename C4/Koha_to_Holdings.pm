package C4::Koha_to_Holdings;

use strict;
use MARC::Record;
use MARC::Field;
	
sub map{	#función principal
	my $marc = $_[1];		#registro marc a mapear
	my $campos_map = campos_map(); #campos de mapeo
	my $campoOUT = $campos_map->[0]; #campo Holding
	my $subcampoOUT = $campos_map->[1]; #subcampo Holding
	my $subcampoIN = $campos_map->[2]; #subcampo ítem
	my @campos = $marc->fields(); #recojo los campos del registro
	datos_embebido($marc); #añado los datos del campo 842
	for(my $i=0; $campos[$i]; $i++){	#recorro todos los campos
		if($campos[$i]->tag() eq "952"){ #si encuentro un ítem
			my $campo = "";	#creo un nuevo campo para el holding
			for(my $j=0; $subcampoIN->[$j]; $j++){	#hago el mapeo del campo
				$campo = mapeo($marc,$campos[$i],$campoOUT->[$j],$subcampoOUT->[$j],$subcampoIN->[$j],$campo);
			}
			$marc->delete_field($campos[$i]);	#elimino el ítem mapeado
		}
	}
	
	@campos = $marc->field("9..");	#guardo los campos 9.. en un array
	for(my $i=0; $campos[$i]; $i++){
		$marc->delete_field($campos[$i]);	#elimino los campos 9.. de koha
	}
	@campos = $marc->fields();	#guardo los campos en un array
	for(my $i=0; $campos[$i]; $i++){
		$marc->delete_field($campos[$i]);	#elimino los campos
	}
	$marc->insert_fields_ordered(@campos);	#inserto de nuevo los campos ordenados
	return $marc;	#devuelvo el registro mapeado
}
	
	sub mapeo{	#procedimiento de mapeo
		my ($marc,$campoIN, $campoOUT, $subcampoOUT, $subcampoIN, $campo) = @_;
		if(!$campoIN->is_control_field() && $campoIN->subfield($subcampoIN)){	#si no es un campo de control y el 		subcampo a mapear existe
				my $data = $campoIN->subfield($subcampoIN);	#recojo el dato del subcampo a mapear
				if($subcampoIN eq "7"){	#Paso a texto los valores de Koha
					if(!$data || $data==0){	
						$data = 0;
					}else{
						if($data==1){
							$data = "NotForLoan";
						}elsif($data==2){
							$data = "StaffCollection";
						}elsif($data==-1){
							$data = "Ordered";
						}
					}
				}elsif($subcampoIN eq "0"){	#Paso a texto los valores de Koha
					if($data==1){	
						$data = "Withdrawn";
					}else{
						$data = 0;
					}
				}elsif($subcampoIN eq "1"){	#Paso a texto los valores de Koha
					if(!$data || $data==0){	
						$data = 0;
					}else{
						if($data==1){
							$data = "Lost";
						}elsif($data==2){
							$data = "LongOverdue(Lost)";
						}elsif($data==3){
							$data = "LostAndPaidFor";
						}elsif($data==4){
							$data = "Missing";
						}
					}
				}elsif($subcampoIN eq "4"){	#Paso a texto los valores de Koha
					if($data==1){	
						$data = "Damaged";
					}else{
						$data = 0;
					}
				}elsif($subcampoIN eq "5"){	#Paso a texto los valores de Koha
					if($data==1){	
						$data = "RestrictedAccess";
					}else{
						$data = 0;
					}
				}elsif($subcampoIN eq "o"){	#desesctructuro el item.callnumber
					$data =~ /^\s*(\d+) (\d+) (\d+) (\d+)\s*$/; 
					if($subcampoOUT eq "k"){	#Call number prefix
						$data = $1;
					}elsif($subcampoOUT eq "h"){	#Classification part
						$data = $2;
					}elsif($subcampoOUT eq "i"){	#Item part
						$data = $3;
					}elsif($subcampoOUT eq "m"){	#Call number suffix
						$data = $4;
					}
				}
				if(!$campo || $campo->tag() ne $campoOUT){ #si no se ha creado el campo o es un campo nuevo
					$campo =  MARC::Field->new($campoOUT,'','', "8" => $marc->field("952")->subfield("9"));	#creo el nuevo campo con el itemnumber como secuencia de vínculo del holding
					$marc->insert_grouped_field( $campo );	#inserto el campo en el registro
				}	
				$campo->add_subfields( $subcampoOUT => $data );	#inserto el subcampo en el campo
		}
		return $campo;	#retorno el campo actual de mapeo
	}
		
	sub campos_map{ #campos a mapear
		my @subcampoIN = ("w","t","p","a","b","o","o","o","o","c","2","3","f","j","u","x","z","4","z","v","7","5","d","g","7","1","0","4","5","c");	#subcampo a leer
		my @campoOUT = ("365","852","852","852","852","852","852","852","852","852","852","852","852","852","852","852","852","852","852","876","876","876","876","876","876","876","876","876","876","876");	#campo a escribir
		my @subcampoOUT = ("f","t","p","a","b","k","h","i","m","c","2","3","f","j","u","x","z","u","q","b","a","a","d","h","h","j","j","j","j","l");	#subcampo a escribir
		my @campos_map = (\@campoOUT, \@subcampoOUT, \@subcampoIN);
		return \@campos_map;	#retorno todo en un array
	}
	
	sub datos_embebido{
		my $marc = shift;
		my $campo_841 =  MARC::Field->new("841",'#','#', "a" => "x");	#creo el nuevo campo con el subcampo para una sola parte
		$marc->insert_grouped_field( $campo_841 );	#inserto el campo en el registro
        if($marc->field("942") && $marc->field("942")->subfield("c")){
            my $campo_842 =  MARC::Field->new("842",'#','#', "a" => $marc->field("942")->subfield("c"));	#creo el nuevo campo con el tipo de ítem
            $marc->insert_grouped_field( $campo_842 );	#inserto el campo en el registro
        }
	}
	
	#my $dbh = C4::Context->dbh;
	
	return 1;	#devuelvo verdadero
	