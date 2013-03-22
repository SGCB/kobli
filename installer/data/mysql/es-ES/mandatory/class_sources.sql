
/*Data for the table `class_sort_rules` */

insert  into `class_sort_rules`(`class_sort_rule`,`description`,`sort_routine`) values ('dewey','Reglas de correspondencia definidas para DDC','Dewey'),('generic','Reglas de correspondencia genéricas para signaturas','Generic'),('lcc','Reglas de correspondencia definidas para LCC','LCC');

/*Data for the table `class_sources` */

insert  into `class_sources`(`cn_source`,`description`,`used`,`class_sort_rule`) values ('anscr','ANSCR (Sound Recordings)',0,'generic'),('ddc','Dewey Decimal Classification',1,'dewey'),('lcc','Library of Congress Classification',1,'lcc'),('sudocs','SuDoc Classification (U.S. GPO)',0,'generic'),('udc','Universal Decimal Classification',0,'generic'),('z','Other/Generic Classification Scheme',0,'generic');

