package C4::Holdings_to_Serial;

use strict;
use MARC::Record;
use MARC::Field;
use C4::Context;
use C4::Charset;
use C4::Holdings_to_Koha;

sub map{  #función principal

  my $dbh = $_[1];    #recibo la conexión a la base de datos
  my $record = $_[2]; #recibo el registro con los serials
  my $marc_records = $_[3]; #recibo el biblionumber del registro en la bd
  my $encoding = $_[4];
  
  if($record->field("004")){
    foreach my $marc_blob (split(/\x1D/, $marc_records)) {
      $marc_blob =~ s/^\s+//g;
      $marc_blob =~ s/\s+$//g;
      next unless $marc_blob;
      my ($marc_record, $charset_guessed, $char_errors) =
          MarcToUTF8Record($marc_blob, C4::Context->preference("marcflavour"), $encoding);

      $encoding = $charset_guessed unless $encoding;

      if (scalar($marc_record->fields()) > 0) {
        if($marc_record->field("001") && ($record->field("004")->data() eq $marc_record->field("001")->data())){
          my $campo_942 =  MARC::Field->new("942",'','', "k" => '1');	#creo el nuevo campo con el flag de serial
          $marc_record->insert_grouped_field( $campo_942 );	#inserto el campo en el registro
          my @c8 = $record->field("952");
          for(my $i=0; $c8[$i]; $i++){
            $marc_record->insert_grouped_field($c8[$i]);
          }
          C4::Holdings_to_Koha->map($marc_record); #MAPEO DE HOLDINGS
          if($marc_record->field("020") && $marc_record->field("020")->subfield("a")){
            my $query = "SELECT biblionumber FROM biblioitems WHERE isbn = ?";
            my $sth = $dbh->prepare($query);
            $sth->execute($marc_record->field("020")->subfield("a"));
            my $data = $sth->fetchrow_hashref();
            my $field = $data->{'biblionumber'}; 
            $query = "SELECT COUNT(*) as items FROM items WHERE biblionumber = ?";
            $sth = $dbh->prepare($query);
            $sth->execute($field);
            $data = $sth->fetchrow_hashref();
            $field = $data->{'items'}; 
            if($field < 1){
              $query = "DELETE FROM biblio WHERE biblionumber = ?";
              $sth = $dbh->prepare($query);
              $sth->execute($field);
              $query = "DELETE FROM biblioitems WHERE biblionumber = ?";
              $sth = $dbh->prepare($query);
              $sth->execute($field);
            }
          }
          return $marc_record;
        }
      }
    }
  }
  return $record;
}
	return 1;	#devuelvo verdadero