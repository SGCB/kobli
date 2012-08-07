package C4::Holdings_to_Koha;

use strict;
use MARC::Record;
use MARC::Field;
	
sub map{	#función principal
	my $marc = $_[1];		#registro marc a mapear
	my $campos_map = campos_map(); #campos de mapeo
	my $campoOUT = "952";
	my $subcampoOUT = $campos_map->[0]; #subcampo del ítem
	my $campoIN = $campos_map->[1]; #campo Holding
	my $subcampoIN = $campos_map->[2]; #subcampo Holding
	my @campos = $marc->fields(); #recojo los campos del registro
	my $campo = "";	#creo un nuevo campo para el ítem
	my $call_number = "";
	
	if($marc->field("841")){
    $marc->delete_field($marc->field("841"));
  }
	datos_942($marc); #añado los datos del campo 942
	
	my @campos_852;
	for(my $i=0; $campos[$i]; $i++){
		if($campos[$i]->tag eq "852"){
			push(@campos_852, $campos[$i]);
			splice(@campos, $i, 1);
			$i--;
		}
	}
	
	for(my $i=0; $campos_852[$i]; $i++){	#recorro todos los campos 852
		$campo = "";	#creo un nuevo campo para el ítem
		$call_number = "";
		for(my $j=0; $campoIN->[$j] le '852' && $campos_852[$i]; $j++){	#hago el mapeo del campo
			$campo = mapeo($marc,$campos_852[$i],$campoOUT,$subcampoOUT->[$j],$campoIN->[$j],$subcampoIN->[$j],$campo,$call_number);
		}
		$marc->delete_field($campos_852[$i]);	#elimino el ítem mapeado
	}
	
	my @campos_952 = $marc->fields();
		for(my $i=0; $i < scalar(@campos_952); $i++){
		if($campos_952[$i]->tag() ne "952"){
			splice(@campos_952, $i, 1);
			$i--;
		}
	}
	
	for(my $i=0; $campos[$i]; $i++){	#recorro todos los campos restantes
		$call_number = "";
		for(my $cont=0; $campos_952[$cont]; $cont++){
			if(!$campos[$i]->is_control_field() && $campos[$i]->subfield("8") && $campos_952[$cont]->subfield("8") eq $campos[$i]->subfield("8")){
				$campo = $campos_952[$cont];
				for(my $j=0; $campoIN->[$j] && $campos[$i]; $j++){	#hago el mapeo del campo
					if($campos[$i]->tag() eq $campoIN->[$j]){
						$campo = mapeo($marc,$campos[$i],$campoOUT,$subcampoOUT->[$j],$campoIN->[$j],$subcampoIN->[$j],$campo,$call_number);
					}
				}
				$marc->delete_field($campos[$i]);	#elimino el ítem mapeado
				$cont = @campos_952;
			}
		}
	}
	
	for(my $i=0; $campos_952[$i]; $i++){
    if($campos_952[$i]->subfield("8")){
      $campos_952[$i]->delete_subfield(code => '8');
    }
	}
	
	@campos = $marc->fields();	#guardo los campos
	for(my $i=0; $campos[$i]; $i++){
		$marc->delete_field($campos[$i]);	#elimino los campos
	}
	$marc->insert_fields_ordered(@campos);	#inserto de nuevo los campos ordenados
	return $marc;	#devuelvo el registro mapeado
  }
	
	sub mapeo{	#procedimiento de mapeo
		my ($marc,$map_field, $campoOUT, $subcampoOUT, $campoIN, $subcampoIN, $campo, $call_number) = @_;
		if(!$map_field->is_control_field() && $map_field->subfield($subcampoIN)){	#si no es un campo de control y el 		subcampo a mapear existe
				my $data = $map_field->subfield($subcampoIN);	#recojo el dato del subcampo a mapear
				if($subcampoIN eq "7"){	#Paso a entero los valores del holding
					if(!$data || $data==0){	
						$data = 0;
					}else{
						if(uc $data =~ m/STAFF/){
							$data = 2;
						}elsif(uc $data =~ m/ORDER/){
							$data = -1;
						}else{
							$data = 1;
						}
					}
				}elsif($subcampoOUT eq "0"){	#Paso a entero los valores del holding
					if($data){	
						$data = 1;
					}else{
						$data = 0;
					}
				}elsif($subcampoOUT eq "1"){	#Paso a entero los valores del holding
					if(!$data || $data eq "0"){	
						$data = 0;
					}else{
						if(uc $data =~ m/LONG/){
							$data = 2;
						}elsif(uc $data =~ m/PAID/){
							$data = 3;
						}elsif(uc $data =~ m/MISSING/){
							$data = 4;
						}else{
							$data = 1;
						}
					}
				}elsif($subcampoOUT eq "4"){	#Paso a entero los valores del holding
					if($data){	
						$data = 1;
					}else{
						$data = 0;
					}
				}elsif($subcampoOUT eq "5"){	#Paso a entero los valores del holding
					if($data){	
						$data = 1;
					}else{
						$data = 0;
					}
				}elsif($subcampoOUT eq "o"){	#desesctructuro el item.callnumber
					if($subcampoIN eq "k"){	#Call number prefix
						$call_number = $data;
					}elsif($subcampoIN eq "h"){	#Classification part
						$call_number = $call_number." ".$data;
					}elsif($subcampoIN eq "i"){	#Item part
						$call_number = $call_number." ".$data;
					}elsif($subcampoIN eq "m"){	#Call number suffix
						$data = $call_number." ".$data;
					}
				}
				if(!$campo){ #si no se ha creado el campo o es un campo nuevo
          if($marc->field("852") && $marc->field("852")->subfield("8")){
            $campo =  MARC::Field->new($campoOUT,'','', "8" => $marc->field("852")->subfield("8"));	#creo el nuevo campo con el itemnumber como secuencia de vínculo del holding
          }else{
            $campo =  MARC::Field->new($campoOUT,'','', "8" => "x");
          }
					$marc->insert_grouped_field( $campo );	#inserto el campo en el registro
				}	
				$campo->add_subfields( $subcampoOUT => $data );	#inserto el subcampo en el campo
		}
		return $campo;	#retorno el campo actual de mapeo
	}
		
	sub campos_map{ #campos a mapear
		my @campoIN = ("365","852","852","852","852","852","852","852","852","852","852","852","852","852","852","852","852","852","852","876","876","876","876","876","876","876","876","876","876","876","877","877","877","877","877","877","877","877","877","877","877","878","878","878","878","878","878","878","878","878","878","878");	#campo a leer
		my @subcampoIN =  ("f","t","p","a","b","k","h","i","m","c","2","3","f","j","u","x","z","u","q","b","a","a","d","h","h","j","j","j","j","l","b","a","a","d","h","h","j","j","j","j","l","b","a","a","d","h","h","j","j","j","j","l");	#subcampo a leer
		my @subcampoOUT = ("w","t","p","a","b","o","o","o","o","c","2","3","f","j","u","x","z","4","z","v","7","5","d","g","7","1","0","4","5","c","v","7","5","d","g","7","1","0","4","5","c","v","7","5","d","g","7","1","0","4","5","c");	#subcampo a escribir
		my @campos_map = (\@subcampoOUT, \@campoIN, \@subcampoIN);
		return \@campos_map;	#retorno todo en un array
	}
	
	sub datos_942{
		my $marc = shift;
        if($marc->field("842") and $marc->field("842")->subfield("a")){
            my $campo_942 =  MARC::Field->new("942",'','', "c" => $marc->field("842")->subfield("a"));	#creo el nuevo campo con el tipo de ítem
            $marc->insert_grouped_field( $campo_942 );	#inserto el campo en el registro
            $marc->delete_field($marc->field("842"));	#elimino el campo ya mapeado
        }
	}
	
	
return 1;	#devuelvo verdadero