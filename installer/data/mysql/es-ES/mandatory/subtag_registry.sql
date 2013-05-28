-- http://www.w3.org/International/articles/language-tags/

-- BIDI Stuff, Arabic and Hebrew
INSERT INTO language_script_bidi(rfc4646_subtag,bidi)
VALUES( 'Arab', 'rtl');
INSERT INTO language_script_bidi(rfc4646_subtag,bidi)
VALUES( 'Hebr', 'rtl');

-- Default mappings between script and language subcodes
INSERT INTO language_script_mapping(language_subtag,script_subtag)
VALUES( 'ar', 'Arab');
INSERT INTO language_script_mapping(language_subtag,script_subtag)
VALUES( 'he', 'Hebr');

-- EXTENSIONS
-- Interface (i)
-- SELECT * FROM language_subtag_registry WHERE type='i';
-- OPAC
INSERT INTO language_subtag_registry( subtag, type, description, added)
VALUES ( 'opac', 'i', 'OPAC','2005-10-16');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'opac', 'i', 'en', 'OPAC');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'opac', 'i', 'fr', 'OPAC');

-- Staff Client
INSERT INTO language_subtag_registry (subtag, type, description, added)
VALUES('intranet','i','Intranet','2005-10-16');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'intranet', 'i', 'en', 'Staff Client');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'intranet', 'i', 'fr', '????');

-- Theme (t)
INSERT INTO language_subtag_registry( subtag, type, description, added)
VALUES ( 'prog', 't', 'Prog','2005-10-16');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'prog', 't', 'en', 'Prog');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'prog', 't', 'fr', 'Prog');

-- LANGUAGES

-- Arabic
insert into language_subtag_registry (subtag, type, description, added) values('ar','language','Árabe','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'ar','ara');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES ( 'ar', 'language', 'ar', '&#1575;&#1604;&#1593;&#1585;&#1576;&#1610;&#1577;');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'ar', 'language', 'en', 'Arabic');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'ar', 'language', 'fr', 'Arabe');

-- Armenian
insert into language_subtag_registry (subtag, type, description, added) values('hy','language','Armenio','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'hy','arm');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES ( 'hy', 'language', 'hy', '&#1344;&#1377;&#1397;&#1381;&#1408;&#1383;&#1398;');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'hy', 'language', 'en', 'Armenian');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'hy', 'language', 'fr', 'Armenian');

-- Bulgarian
insert into language_subtag_registry (subtag, type, description, added) values('bg','language','Búlgaro','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'bg','bul');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES ( 'bg', 'language', 'bg', '&#1041;&#1098;&#1083;&#1075;&#1072;&#1088;&#1089;&#1082;&#1080;');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'bg', 'language', 'en', 'Bulgarian');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'bg', 'language', 'fr', 'Bulgare');

-- Chinese
insert into language_subtag_registry (subtag, type, description, added) values('zh','language','Chino','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'zh','chi');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES ( 'zh', 'language', 'zh', '&#20013;&#25991;');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'zh', 'language', 'en', 'Chinese');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'zh', 'language', 'fr', 'Chinois');

-- Czech
insert into language_subtag_registry (subtag, type, description, added) values('cs','language','Checo','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'cs','cze');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES ( 'cs', 'language', 'cs', '&#x010D;e&#353;tina');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'cs', 'language', 'en', 'Czech');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'cs', 'language', 'fr', 'Tchèque');

-- Danish
insert into language_subtag_registry (subtag, type, description, added) values('da','language','Danés','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'da','dan');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES ( 'da', 'language', 'da', 'D&aelig;nsk');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'da', 'language', 'en', 'Danish');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'da', 'language', 'fr', 'Danois');

-- Dutch, Flemish
insert into language_subtag_registry (subtag, type, description, added) values('nl','language','Holandés','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'nl','dut');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES ( 'nl', 'language', 'nl', 'ned&#601;rl&#593;ns');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'nl', 'language', 'en', 'Dutch');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'nl', 'language', 'fr', 'Néerlandais');

-- English
insert into language_subtag_registry (subtag, type, description, added) values('en','language','Inglés','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'en','eng');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'en', 'language', 'en', 'English');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'en', 'language', 'fr', 'Anglais');

-- Finnish
insert into language_subtag_registry (subtag, type, description, added) values('fi','language','Finés','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'fi','fin');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'fi', 'language', 'fi', 'suomi');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'fi', 'language', 'en', 'Finnish');

-- French
insert into language_subtag_registry (subtag, type, description, added) values('fr','language','Francés','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'fr','fre');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'fr', 'language', 'en', 'French');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'fr', 'language', 'fr', 'Fran&ccedil;ais');

-- INSERT INTO language_descriptions(subtag, type, lang, description)
-- VALUES( 'fr-CA', 'language', 'fr-CA', 'fran&ccedil;ais');

-- Lao
insert into language_subtag_registry (subtag, type, description, added) values('lo','language','Lao','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'lo','lao');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'lo', 'language', 'lo', '&#3742;&#3762;&#3754;&#3762;&#3749;&#3762;&#3751;');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'lo', 'language', 'en', 'Lao');

-- German
insert into language_subtag_registry (subtag, type, description, added) values('de','language','Alemán','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'de','ger');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'de', 'language', 'de', 'Deutsch');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'de', 'language', 'en', 'German');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'de', 'language', 'fr', 'Allemand');

-- Greek
insert into language_subtag_registry (subtag, type, description, added) values('el','language','Griego moderno [1453- ]','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'el','gre');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'el', 'language', 'el', '&#949;&#955;&#955;&#951;&#957;&#953;&#954;&#940;');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'el', 'language', 'en', 'Greek, Modern [1453- ]');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'el', 'language', 'fr', 'Grec Moderne (Après 1453)');

-- Hebrew
insert into language_subtag_registry (subtag, type, description, added) values('he','language','Hebreo','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'he','heb');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'he', 'language', 'he', '&#1506;&#1489;&#1512;&#1497;&#1514;');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'he', 'language', 'en', 'Hebrew');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'he', 'language', 'fr', 'Hébreu');

-- Hindi
INSERT INTO language_subtag_registry( subtag, type, description, added)
VALUES ( 'hi', 'language', 'Hindi','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'hi','hin');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'hi', 'language', 'hi', '&#2361;&#2367;&#2344;&#2381;&#2342;&#2368;');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'hi', 'language', 'en', 'Hindi');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'hi', 'language', 'fr', 'Hindi');

-- Hungarian
insert into language_subtag_registry (subtag, type, description, added) values('hu','language','Húngaro','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'hu','hun');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'hu', 'language', 'hu', 'Magyar');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'hu', 'language', 'en', 'Hungarian');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'hu', 'language', 'fr', 'Hongrois');

-- Indonesian
insert into language_subtag_registry (subtag, type, description, added) values('id','language','Indonesio','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'id','ind');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'id', 'language', 'id', 'Bahasa Indonesia');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'id', 'language', 'en', 'Indonesian');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'id', 'language', 'fr', 'Indonésien');

-- Italian
insert into language_subtag_registry (subtag, type, description, added) values('it','language','Italiano','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'it','ita');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'it', 'language', 'it', 'Italiano');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'it', 'language', 'en', 'Italian');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'it', 'language', 'fr', 'Italien');

-- Japanese
insert into language_subtag_registry (subtag, type, description, added) values('ja','language','Japonés','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'ja','jpn');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'ja', 'language', 'ja', '&#26085;&#26412;&#35486;');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'ja', 'language', 'en', 'Japanese');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'ja', 'language', 'fr', 'Japonais');

-- Korean
insert into language_subtag_registry (subtag, type, description, added) values('ko','language','Coreano','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'ko','kor');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'ko', 'language', 'ko', '&#54620;&#44397;&#50612;');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'ko', 'language', 'en', 'Korean');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'ko', 'language', 'fr', 'Coréen');

-- Latin
insert into language_subtag_registry (subtag, type, description, added) values('la','language','Latín','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'la','lat');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'la', 'language', 'la', 'Latina');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'la', 'language', 'en', 'Latin');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'la', 'language', 'fr', 'Latin');

-- Galician

insert into language_subtag_registry (subtag, type, description, added) values('gl','language','Gallego','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'gl','glg');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'gl', 'language', 'gl', 'Galego');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'gl', 'language', 'en', 'Galician');

-- Norwegian
insert into language_subtag_registry (subtag, type, description, added) values('nb','language','Noruego','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'nb','nor');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'nb','nob');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'nb', 'language', 'nb', 'Norsk');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'nb', 'language', 'en', 'Norwegian');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'nb', 'language', 'fr', 'Norvégien');

-- Persian
insert into language_subtag_registry (subtag, type, description, added) values('fa','language','Farsi / persa','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'fa','per');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'fa', 'language', 'fa', '&#1601;&#1575;&#1585;&#1587;&#1609;');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'fa', 'language', 'en', 'Persian');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'fa', 'language', 'fr', 'Persan');

-- Polish
insert into language_subtag_registry (subtag, type, description, added) values('pl','language','Polaco','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'pl','pol');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'pl', 'language', 'pl', 'Polski');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'pl', 'language', 'en', 'Polish');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'pl', 'language', 'fr', 'Polonais');

-- Portuguese
insert into language_subtag_registry (subtag, type, description, added) values('pt','language','Portugués','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'pt','por');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'pt', 'language', 'pt', 'Portugu&ecirc;s');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'pt', 'language', 'en', 'Portuguese');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'pt', 'language', 'fr', 'Portugais');

-- Romanian
insert into language_subtag_registry (subtag, type, description, added) values('ro','language','Rumano','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'ro','rum');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'ro', 'language', 'ro', 'Rom&acirc;n&#259;');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'ro', 'language', 'en', 'Romanian');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'ro', 'language', 'fr', 'Roumain');

-- Russian
insert into language_subtag_registry (subtag, type, description, added) values('ru','language','Ruso','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'ru','rus');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'ru', 'language', 'ru', '&#1056;&#1091;&#1089;&#1089;&#1082;&#1080;&#1081;');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'ru', 'language', 'en', 'Russian');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'ru', 'language', 'fr', 'Russe');

-- Serbian
insert into language_subtag_registry (subtag, type, description, added) values('sr','language','Serbio','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'sr','srp');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'sr', 'language', 'sr', '&#1089;&#1088;&#1087;&#1089;&#1082;&#1080;');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'sr', 'language', 'en', 'Serbian');

-- Spanish, Castilian
insert into language_subtag_registry (subtag, type, description, added) values('es','language','Español','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'es','spa');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'es', 'language', 'es', 'Español');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'es', 'language', 'en', 'Spanish');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'es', 'language', 'fr', 'Espagnol');

-- Swedish
insert into language_subtag_registry (subtag, type, description, added) values('sv','language','Sueco','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'sv','swe');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'sv', 'language', 'sv', 'Svenska');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'sv', 'language', 'en', 'Swedish');   

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'sv', 'language', 'fr', 'Suédois');

-- Tetum
insert into language_subtag_registry (subtag, type, description, added) values('tet','language','Tetun','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'tet','tet');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'tet', 'language', 'tet', 'tetun');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'tet', 'language', 'en', 'Tetum');

-- Thai
insert into language_subtag_registry (subtag, type, description, added) values('th','language','Thai','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'th','tha');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'th', 'language', 'th', '&#3616;&#3634;&#3625;&#3634;&#3652;&#3607;&#3618;');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'th', 'language', 'en', 'Thai');   

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'th', 'language', 'fr', 'Thaï');

-- Turkish
insert into language_subtag_registry (subtag, type, description, added) values('tr','language','Turco','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'tr','tur');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'tr', 'language', 'tr', 'T&uuml;rk&ccedil;e');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'tr', 'language', 'en', 'Turkish');   

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'tr', 'language', 'fr', 'Turc');


-- Ukranian
insert into language_subtag_registry (subtag, type, description, added) values('uk','language','Ucraniano','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'uk','ukr');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'uk', 'language', 'uk', '&#1059;&#1082;&#1088;&#1072;&#1111;&#1085;&#1089;&#1100;&#1082;&#1072;');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'uk', 'language', 'en', 'Ukranian');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'uk', 'language', 'fr', 'Ukrainien');

-- Urdu
insert into language_subtag_registry (subtag, type, description, added) values('ur','language','Urdu','2005-10-16');

INSERT INTO language_rfc4646_to_iso639(rfc4646_subtag,iso639_2_code)
VALUES( 'ur','urd');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'ur', 'language', 'en', 'Urdu');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'ur', 'language', 'ur', '&#1575;&#1585;&#1583;&#1608;');

-- SCRIPTS
-- Arabic
insert into language_subtag_registry (subtag, type, description, added) values('Arab','script','Árabe','2005-10-16');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES ( 'Arab','script', 'Arab', '&#1575;&#1604;&#1593;&#1585;&#1576;&#1610;&#1577;');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'Arab', 'script','en', 'Arabic');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'Arab', 'script','fr', 'Arabic');

-- Cyrillic
insert into language_subtag_registry (subtag, type, description, added) values('Cyrl','script','Cirílico','2005-10-16');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES ( 'Cyrl', 'script', 'Cyrl', '????');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'Cyrl', 'script', 'en', 'Cyrillic');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'Cyrl', 'script', 'fr', 'Cyrillic');

-- Greek
insert into language_subtag_registry (subtag, type, description, added) values('Grek','script','Griego ','2005-10-16');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES ( 'Grek', 'script', 'Grek', '????');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'Grek', 'script', 'en', 'Greek');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'Grek', 'script', 'fr', 'Greek');

-- Han - Simplified
insert into language_subtag_registry (subtag, type, description, added) values('Hans','script','Han (variante simplificad','2005-10-16');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES ( 'Hans', 'script', 'Hans', 'Han (Simplified variant)');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'Hans', 'script', 'en', 'Han (Simplified variant)');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'Hans', 'script', 'fr', 'Han (Simplified variant)');

-- Han - Traditional
insert into language_subtag_registry (subtag, type, description, added) values('Hant','script','Han (variante tradicional','2005-10-16');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES ( 'Hant', 'script', 'Hant', 'Han (Traditional variant)');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'Hant', 'script', 'en', 'Han (Traditional variant)');

-- Hebrew
insert into language_subtag_registry (subtag, type, description, added) values('Hebr','script','Hebreo','2005-10-16');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES ( 'Hebr', 'script', 'Hebr', 'Hebrew');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'Hebr', 'script', 'en', 'Hebrew');

-- Lao
insert into language_subtag_registry (subtag, type, description, added) values('Laoo','script','Lao','2005-10-16');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES ( 'Laoo', 'script', 'lo', 'Lao');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'Laoo', 'script', 'en', 'Lao');

-- REGIONS
-- Canada
insert into language_subtag_registry (subtag, type, description, added) values('CA','region','Canadá','2005-10-16');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'CA', 'region', 'en', 'Canada');

-- Denmark
insert into language_subtag_registry (subtag, type, description, added) values('DK','region','Dinamarca','2005-10-16');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'DK', 'region', 'dk', 'Danmark');

-- France
insert into language_subtag_registry (subtag, type, description, added) values('FR','region','Francia','2005-10-16');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES ( 'FR', 'region', 'fr', 'France');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'FR', 'region', 'en', 'France');

-- New Zealand
insert into language_subtag_registry (subtag, type, description, added) values('NZ','region','Nueva Zelanda','2005-10-16');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'NZ', 'region', 'en', 'New Zealand');

-- United Kingdom
insert into language_subtag_registry (subtag, type, description, added) values('GB','region','Reino Unido','2005-10-16');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'GB', 'region', 'en', 'United Kingdom');

-- United States
insert into language_subtag_registry (subtag, type, description, added) values('US','region','Estados Unidos de América','2005-10-16');

INSERT INTO language_descriptions(subtag, type, lang, description)
VALUES( 'US', 'region', 'en', 'United States');
