--
-- System preferences that differ from the global defaults
--
-- This file is part of Koha.
--
-- Koha is free software; you can redistribute it and/or modify it under the
-- terms of the GNU General Public License as published by the Free Software
-- Foundation; either version 2 of the License, or (at your option) any later
-- version.
-- 
-- Koha is distributed in the hope that it will be useful, but WITHOUT ANY
-- WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
-- A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License along
-- with Koha; if not, write to the Free Software Foundation, Inc.,
-- 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

UPDATE systempreferences SET value = 'incremental' WHERE variable = 'autoBarcode';
UPDATE systempreferences SET value = 'surname|cardnumber' WHERE variable = 'BorrowerMandatoryField';
UPDATE systempreferences SET value = 'Господин|Госпожа|Мистер|Миссис|Уважаемый|Уважаемая|Товарищ|Добродий|Добродийка' WHERE variable = 'BorrowersTitles';
UPDATE systempreferences SET value = 'metric' WHERE variable = 'dateformat';
UPDATE systempreferences SET value = 'udc' WHERE variable = 'DefaultClassificationSource';
UPDATE systempreferences SET value = '1' WHERE variable = 'ExtendedPatronAttributes';
UPDATE systempreferences SET value = '0.20' WHERE variable = 'gist';
UPDATE systempreferences SET value = '942hv' WHERE variable = 'itemcallnumber';
UPDATE systempreferences SET value = 'uk-UA,ru-RU,en,fr-FR,de-DE' WHERE variable = 'language';
UPDATE systempreferences SET value = 'uk-UA,ru-RU,en,fr-FR,de-DE' WHERE variable = 'opaclanguages';
UPDATE systempreferences SET value = 'Вітаємо у АБІС Koha...\r\n<hr>' WHERE variable = 'OpacMainUserBlock';
UPDATE systempreferences SET value = 'Тут будуть важливі посилання.' WHERE variable = 'OpacNav';
UPDATE systempreferences SET value = '1' WHERE variable = 'patronimages';

UPDATE systempreferences SET value = '#200|<h2>Заголовок: |{200a}{. 200c}{ : 200e}{200d}{. 200h}{. 200i}|</h2>\r\n#500|<label class="ipt">Уніфікована назва: </label>|{500a}{. 500i}{. 500h}{. 500m}{. 500q}{. 500k}<br/>|\r\n#517|<label class="ipt"> </label>|{517a}{ : 517e}{. 517h}{, 517i}<br/>|\r\n#541|<label class="ipt"> </label>|{541a}{ : 541e}<br/>|\r\n#200||<label class="ipt">Автори: </label><br/>|\r\n#700||<a href="opac-search.pl?op=do_search&marclist=7009&operator==&type=intranet&value={7009}"> <img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за автором"></a>{700c}{ 700b}{ 700a}{ 700d}{ (700f)}{. 7004}<br/>|\r\n#701||<a href="opac-search.pl?op=do_search&marclist=7009&operator==&type=intranet&value={7019}"> <img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за автором"></a>{701c}{ 701b}{ 701a}{ 701d}{ (701f)}{. 7014}<br/>|\r\n#702||<a href="opac-search.pl?op=do_search&marclist=7009&operator==&type=intranet&value={7029}"> <img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за автором"></a>{702c}{ 702b}{ 702a}{ 702d}{ (702f)}{. 7024}<br/>|\r\n#710||<a href="opac-search.pl?op=do_search&marclist=7109&operator==&type=intranet&value={7109}"> <img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за автором"></a>{710a}{ (710c)}{. 710b}{ : 710d}{ ; 710f}{ ; 710e}<br/>|\r\n#711||<a href="opac-search.pl?op=do_search&marclist=7109&operator==&type=intranet&value={7119}"> <img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за автором"></a>{711a}{ (711c)}{. 711b}{ : 711d}{ ; 711f}{ ; 711e}<br/>|\r\n#712||<a href="opac-search.pl?op=do_search&marclist=7109&operator==&type=intranet&value={7129}"> <img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за автором"></a>{712a}{ (712c)}{. 712b}{ : 712d}{ ; 712f}{ ; 712e}<br/>|\r\n#210|<label class="ipt">Уніфікована форма назви: </label>|{ 210a}<br/>|\r\n#210|<label class="ipt">Видавець: </label>|{ 210c}<br/>|\r\n#210|<label class="ipt">Дата публікації: </label>|{ 210d}<br/>|\r\n#215|<label class="ipt">Фізичний опис: </label>|{215a}{ : 215c}{ ; 215d}{ + 215e}|<br/>\r\n#225|<label class="ipt">Серія:</label>|<a href="opac-search.pl?op=do_search&marclist=225a&operator==&type=intranet&value={225a}"> <img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за {225a}"></a>{ (225a}{ = 225d}{ : 225e}{. 225h}{. 225i}{ / 225f}{, 225x}{ ; 225v}|)<br/>\r\n#200||<label class="ipt">Предметні рубрики: </label><br/>|\r\n#600||<a href="opac-search.pl?op=do_search&marclist=6009&operator==&type=intranet&value={6009}"><img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за {6009}"></a>{ 600c}{ 600b}{ 600a}{ 600d}{ (600f)} {-- 600x }{-- 600z }{-- 600y}<br />|\r\n#604||<a href="opac-search.pl?op=do_search&marclist=6049&operator==&type=intranet&value={6049}"><img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за {6049}"></a>{ 604a}{. 604t}<br />|\r\n#601||<a href="opac-search.pl?op=do_search&marclist=6019&operator==&type=intranet&value={6019}"><img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за {6019}"></a>{ 601a}{ (601c)}{. 601b}{ : 601d} { ; 601f}{ ; 601e}{ -- 601x }{-- 601z }{-- 601y}<br />|\r\n#605||<a href="opac-search.pl?op=do_search&marclist=6059&operator==&type=intranet&value={6059}"><img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за {6059}"></a>{ 605a}{. 605i}{. 605h}{. 605k}{. 605m}{. 605q} {-- 605x }{-- 605z }{-- 605y }{-- 605l}<br />|\r\n#606||<a href="opac-search.pl?op=do_search&marclist=6069&operator==&type=intranet&value={6069}"><img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за {6069}">xx</a>{ 606a}{-- 606x }{-- 606z }{606y }<br />|\r\n#607||<a href="opac-search.pl?op=do_search&marclist=6079&operator==&type=intranet&value={6079}"><img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за {6079}"></a>{ 607a}{-- 607x}{-- 607z}{-- 607y}<br />|\r\n#010|<label class="ipt">ISBN: </label>|{010a}|<br/>\r\n#011|<label class="ipt">ISSN: </label>|{011a}|<br/>\r\n#200||<label class="ipt">Нотатки: </label>|<br/>\r\n#300||{300a}|<br/>\r\n#320||{320a}|<br/>\r\n#327||{327a}|<br/>\r\n#328||{328a}|<br/>\r\n#200||<br/><h2>Примірники</h2>|\r\n#200|<table>|<th>Місцезнаходження</th><th>Cote</th>|\r\n#995||<tr><td>{995e}&nbsp;&nbsp;</td><td> {995k}</td></tr>|\r\n#200|||</table>' WHERE variable = 'ISBD';

UPDATE systempreferences SET value = "
        'title' => '200a,200c,200d,200e,225a,225d,225e,225f,225h,225i,225v,500*,501*,503*,510*,512*,513*,514*,515*,516*,517*,518*,519*,520*,530*,531*,532*,540*,541*,545*,604t,610t,605a',
        'author' => '200f,600a,601a,604a,700a,700b,700c,700d,700a,701b,701c,701d,702a,702b,702c,702d,710a,710b,710c,710d,711a,711b,711c,711d,712a,712b,712c,712d',
        'se' => '225a',
        'isbn' => '010a',
        'issn' => '011a',
        'biblionumber' => '9999',
        'itemtype' => '200b,942c,952y',
        'language' => '101a',
        'pl' => '210a',
        'publisher' => '210c',
        'date' => '210d',
        'note' => '300a,301a,302a,303a,304a,305a,306az,307a,308a,309a,310a,311a,312a,313a,314a,315a,316a,317a,318a,319a,320a,321a,322a,323a,324a,325a,326a,327a,328a,330a,332a,333a,336a,337a,345a',
        'Koha-Auth-Number' => '6009,6019,6029,6039,6049,6059,6069,6109,7009,7019,7029,7109,7119,7129',
        'subject' => '600*,601*,606*,610*',
        'an' => '6009,6019,6069,6109,6079',
        'su' => '600a,601a,606a,610a,607a,608a',
        'lcn' => '686a,952o',
        'yr' => '210d',
        'mt' => '200b',
        'dewey' => '676a',
        'bc' => '952p',
        'callnum' => '952o',
        'homebranch' => '952a,952c',
        'host-item' => '992b,992c',
        'keyword' => '200*,600*,700*,400*,210*' 
" WHERE variable = 'NoZebraIndexes';
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('OpacRenewalAllowed',0,'If ON, users can renew their issues directly from their OPAC account',NULL,'YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('PatronsPerPage','20','Number of Patrons Per Page displayed by default','20','Integer');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('HomeOrHoldingBranch','holdingbranch','Used by Circulation to determine which branch of an item to check with independent branches on, and by search to determine which branch to choose for availability ','holdingbranch|homebranch','Choice');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('OpacHighlightedWords','1','If Set, then queried words are higlighted in OPAC','','YesNo');

INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('OAI-PMH','0','if ON, OAI-PMH server is enabled',NULL,'YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('OAI-PMH:archiveID','KOHA-OAI-TEST','OAI-PMH archive identification',NULL,'Free');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('OAI-PMH:MaxCount','50','OAI-PMH maximum number of records by answer to ListRecords and ListIdentifiers queries',NULL,'Integer');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('OPACItemHolds','1','Allow OPAC users to place hold on specific items. If OFF, users can only request next available copy.','','YesNo');

INSERT INTO `systempreferences` (variable, value,options,type, explanation) VALUES ('AddPatronLists','categorycode','categorycode|category_type','Choice','Allow user to choose what list to pick up from when adding patrons');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('ExtendedPatronAttributes','1','Use extended patron IDs and attributes',NULL,'YesNo');

INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('RenewSerialAddsSuggestion','0','If ON, adds a new suggestion at serial subscription renewal',NULL,'YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('GoogleJackets','0','if ON, displays jacket covers from Google Books API',NULL,'YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('RandomizeHoldsQueueWeight','0','if ON, the holds queue in circulation will be randomized, either based on all location codes, or by the location codes specified in StaticHoldsQueueWeight',NULL,'YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('StaticHoldsQueueWeight','0','Specify a list of library location codes separated by commas -- the list of codes will be traversed and weighted with first values given higher weight for holds fulfillment -- alternatively, if RandomizeHoldsQueueWeight is set, the list will be randomly selective',NULL,'Integer');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('AutoEmailOpacUser','0','Sends notification emails containing new account details to patrons - when account is created.',NULL,'YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('AutoEmailPrimaryAddress','OFF','Defines the default email address where \'Account Details\' emails are sent.','email|emailpro|B_email|cardnumber|OFF','Choice');

-- Tags and BakerTaylor (note field order differs from above)
INSERT INTO `systempreferences` (variable,value,options,explanation,type) VALUES
	('BakerTaylorBookstoreURL','','','URL template for \"My Libary Bookstore\" links, to which the \"key\" value is appended, and \"https://\" is prepended.  It should include your hostname and \"Parent Number\".  Make this variable empty to turn MLB links off.  Example: ocls.mylibrarybookstore.com/MLB/actions/searchHandler.do?nextPage=bookDetails&parentNum=10923&key=',''),
	('BakerTaylorEnabled','0','','Enable or disable all Baker & Taylor features.','YesNo'),
	('BakerTaylorPassword','','','Baker & Taylor Password for Content Cafe (external content)','Free'),
	('BakerTaylorUsername','','','Baker & Taylor Username for Content Cafe (external content)','Free'),
	('TagsEnabled','1','','Enables or disables all tagging features.  This is the main switch for tags.','YesNo'),
	('TagsExternalDictionary',NULL,'','Path on server to local ispell executable, used to set $Lingua::Ispell::path  This dictionary is used as a \"whitelist\" of pre-allowed tags.',''),
	('TagsInputOnDetail','1','','Allow users to input tags from the detail page.',         'YesNo'),
	('TagsInputOnList',  '0','','Allow users to input tags from the search results list.', 'YesNo'),
	('TagsModeration',  NULL,'','Require tags from patrons to be approved before becoming visible.','YesNo'),
	('TagsShowOnDetail','10','','Number of tags to display on detail page.  0 is off.',        'Integer'),
	('TagsShowOnList',   '6','','Number of tags to display on search results list.  0 is off.','Integer');

INSERT INTO `systempreferences` (variable,value,options,explanation,type) VALUES('OPACShelfBrowser','1','','Enable/disable Shelf Browser on item details page. WARNING: this feature is very resource consuming on collections with large numbers of items.','YesNo');
INSERT INTO `systempreferences` (variable,value,options,explanation,type) VALUES
('XSLTDetailsDisplay','0','','Enable XSL stylesheet control over details page display on OPAC exemple : ../koha-tmpl/opac-tmpl/prog/en/xslt/MARC21slim2OPACDetail.xsl','Textarea'),
('XSLTResultsDisplay','0','','Enable XSL stylesheet control over results page display on OPAC exemple : ../koha-tmpl/opac-tmpl/prog/en/xslt/MARC21slim2OPACResults.xsl','Textarea');
INSERT INTO `systempreferences` (variable,value,options,explanation,type) VALUES('AdvancedSearchTypes','itemtypes','itemtypes|ccode','Select which set of fields comprise the Type limit in the advanced search','Choice');
INSERT INTO `systempreferences` (variable,value,options,explanation,type) VALUES('AllowOnShelfHolds', '0', '', 'Allow hold requests to be placed on items that are not on loan', 'YesNo');
INSERT INTO `systempreferences` (variable,value,options,explanation,type) VALUES('AllowHoldsOnDamagedItems', '1', '', 'Allow hold requests to be placed on damaged items', 'YesNo');
INSERT INTO `systempreferences` (variable,value,options,explanation,type) VALUES('OpacSuppression', '0', '', 'Turn ON the OPAC Suppression feature, requires further setup, ask your system administrator for details', 'YesNo');
-- FIXME: add FrameworksLoaded, noOPACUserLogin?
INSERT INTO `systempreferences` (variable,value,options,explanation,type) VALUES ('SMSSendDriver','','','Sets which SMS::Send driver is used to send SMS messages.','free');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES('AllowRenewalLimitOverride', '0', 'if ON, allows renewal limits to be overridden on the circulation screen',NULL,'YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES('RenewalPeriodBase', 'date_due', 'Set whether the renewal date should be counted from the date_due or from the moment the Patron asks for renewal ','date_due|now','Choice');
INSERT INTO `systempreferences` ( `variable` , `value` , `options` , `explanation` , `type` ) VALUES ( 'AllowNotForLoanOverride', '0', '', 'If ON, Koha will allow the librarian to loan a not for loan item.', 'YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('AWSPrivateKey','','See:  http://aws.amazon.com.  Note that this is required after 2009/08/15 in order to retrieve any enhanced content other than book covers from Amazon.','','free');
INSERT INTO systempreferences (variable,value,explanation,options,type)VALUES('viewISBD','1','Allow display of ISBD view of bibiographic records','','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type)VALUES('viewLabeledMARC','0','Allow display of labeled MARC view of bibiographic records','','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type)VALUES('viewMARC','1','Allow display of MARC view of bibiographic records','','YesNo');

INSERT INTO `systempreferences` (variable,value,options,explanation,type) VALUES ('OPACDisplayRequestPriority','0','','Show patrons the priority level on holds in the OPAC','YesNo');

-- INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('maxItemsInSearchResults',20,'Specify the maximum number of items to display for each result on a page of results',NULL,'free');
-- fix to 2142: maxItemsInSearchResults No longer used

-- from 3.00.04.019

INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('AmazonCoverImages', '0', 'Display Cover Images in Staff Client from Amazon Web Services','','YesNo');
-- from 3.00.02.007

INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('OPACAmazonCoverImages', '0', 'Display cover images on OPAC from Amazon Web Services','','YesNo');
--from 3.00.02.007


INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES('AllowHoldPolicyOverride', '0', 'Allow staff to override hold policies when placing holds',NULL,'YesNo');
-- from 3.00.05.001

INSERT IGNORE INTO systempreferences (variable,explanation,options,type,value)
'#200|<h2>Заголовок: |{200a}{. 200c}{ : 200e}{200d}{. 200h}{. 200i}|</h2>\r\n#500|<label class="ipt">Уніфікована назва: </label>|{500a}{. 500i}{. 500h}{. 500m}{. 500q}{. 500k}<br/>|\r\n#517|<label class="ipt"> </label>|{517a}{ : 517e}{. 517h}{, 517i}<br/>|\r\n#541|<label class="ipt"> </label>|{541a}{ : 541e}<br/>|\r\n#200||<label class="ipt">Автори: </label><br/>|\r\n#700||<a href="opac-search.pl?op=do_search&marclist=7009&operator==&type=intranet&value={7009}"> <img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за автором"></a>{700c}{ 700b}{ 700a}{ 700d}{ (700f)}{. 7004}<br/>|\r\n#701||<a href="opac-search.pl?op=do_search&marclist=7009&operator==&type=intranet&value={7019}"> <img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за автором"></a>{701c}{ 701b}{ 701a}{ 701d}{ (701f)}{. 7014}<br/>|\r\n#702||<a href="opac-search.pl?op=do_search&marclist=7009&operator==&type=intranet&value={7029}"> <img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за автором"></a>{702c}{ 702b}{ 702a}{ 702d}{ (702f)}{. 7024}<br/>|\r\n#710||<a href="opac-search.pl?op=do_search&marclist=7109&operator==&type=intranet&value={7109}"> <img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за автором"></a>{710a}{ (710c)}{. 710b}{ : 710d}{ ; 710f}{ ; 710e}<br/>|\r\n#711||<a href="opac-search.pl?op=do_search&marclist=7109&operator==&type=intranet&value={7119}"> <img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за автором"></a>{711a}{ (711c)}{. 711b}{ : 711d}{ ; 711f}{ ; 711e}<br/>|\r\n#712||<a href="opac-search.pl?op=do_search&marclist=7109&operator==&type=intranet&value={7129}"> <img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за автором"></a>{712a}{ (712c)}{. 712b}{ : 712d}{ ; 712f}{ ; 712e}<br/>|\r\n#210|<label class="ipt">Уніфікована форма назви: </label>|{ 210a}<br/>|\r\n#210|<label class="ipt">Видавець: </label>|{ 210c}<br/>|\r\n#210|<label class="ipt">Дата публікації: </label>|{ 210d}<br/>|\r\n#215|<label class="ipt">Фізичний опис: </label>|{215a}{ : 215c}{ ; 215d}{ + 215e}|<br/>\r\n#225|<label class="ipt">Серія:</label>|<a href="opac-search.pl?op=do_search&marclist=225a&operator==&type=intranet&value={225a}"> <img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за {225a}"></a>{ (225a}{ = 225d}{ : 225e}{. 225h}{. 225i}{ / 225f}{, 225x}{ ; 225v}|)<br/>\r\n#200||<label class="ipt">Предметні рубрики: </label><br/>|\r\n#600||<a href="opac-search.pl?op=do_search&marclist=6009&operator==&type=intranet&value={6009}"><img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за {6009}"></a>{ 600c}{ 600b}{ 600a}{ 600d}{ (600f)} {-- 600x }{-- 600z }{-- 600y}<br />|\r\n#604||<a href="opac-search.pl?op=do_search&marclist=6049&operator==&type=intranet&value={6049}"><img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за {6049}"></a>{ 604a}{. 604t}<br />|\r\n#601||<a href="opac-search.pl?op=do_search&marclist=6019&operator==&type=intranet&value={6019}"><img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за {6019}"></a>{ 601a}{ (601c)}{. 601b}{ : 601d} { ; 601f}{ ; 601e}{ -- 601x }{-- 601z }{-- 601y}<br />|\r\n#605||<a href="opac-search.pl?op=do_search&marclist=6059&operator==&type=intranet&value={6059}"><img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за {6059}"></a>{ 605a}{. 605i}{. 605h}{. 605k}{. 605m}{. 605q} {-- 605x }{-- 605z }{-- 605y }{-- 605l}<br />|\r\n#606||<a href="opac-search.pl?op=do_search&marclist=6069&operator==&type=intranet&value={6069}"><img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за {6069}">xx</a>{ 606a}{-- 606x }{-- 606z }{606y }<br />|\r\n#607||<a href="opac-search.pl?op=do_search&marclist=6079&operator==&type=intranet&value={6079}"><img border="0" src="/opac-tmpl/css/en/images/filefind.png" height="15" title="Пошук за {6079}"></a>{ 607a}{-- 607x}{-- 607z}{-- 607y}<br />|\r\n#010|<label class="ipt">ISBN: </label>|{010a}|<br/>\r\n#011|<label class="ipt">ISSN: </label>|{011a}|<br/>\r\n#200||<label class="ipt">Нотатки: </label>|<br/>\r\n#300||{300a}|<br/>\r\n#320||{320a}|<br/>\r\n#327||{327a}|<br/>\r\n#328||{328a}|<br/>\r\n#200||<br/><h2>Примірники</h2>|\r\n#200|<table>|<th>Місцезнаходження</th><th>Cote</th>|\r\n#995||<tr><td>{995e}&nbsp;&nbsp;</td><td> {995k}</td></tr>|\r\n#200|||</table>');
-- from 3.00.04.020

INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('HomeOrHoldingBranchReturn','homebranch','Used by Circulation to determine which branch of an item to check checking-in items','holdingbranch|homebranch','Choice');
-- from 3.00.06.001

-- from 3.00.06.004

-- from 3.00.06.005

-- from 3.00.06.005

INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('AllowHoldDateInFuture','0','If set a date field is displayed on the Hold screen of the Staff Interface, allowing the hold date to be set in the future.','','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('OPACAllowHoldDateInFuture','0','If set, along with the AllowHoldDateInFuture system preference, OPAC users can set the date of a hold to be in the future.','','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('Babeltheque',0,'Turn ON Babeltheque content  - See babeltheque.com to subscribe to this service','','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('casAuthentication', '0', 'Enable or disable CAS authentication', '', 'YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('casLogout', '0', 'Does a logout from Koha should also log the user out of CAS?', '', 'YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('casServerUrl', 'https://localhost:8443/cas', 'URL of the cas server', '', 'Free');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('intranetbookbag','1','If ON, enables display of Cart feature in the intranet','','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('opacSerialDefaultTab', 'subscriptions', 'Define the default tab for serials in OPAC.', 'holdings|serialcollection|subscriptions', 'Choice');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('numReturnedItemsToShow','20','Number of returned items to show on the check-in page',NULL,'Integer');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('OAI-PMH:ConfFile','','If empty, Koha OAI Server operates in normal mode, otherwise it operates in extended mode.',NULL,'File');
('OPACXSLTDetailsDisplay','0','','Enable XSL stylesheet control over details page display on OPAC','YesNo'),
('OPACXSLTResultsDisplay','0','','Enable XSL stylesheet control over results page display on OPAC','YesNo'),
INSERT INTO `systempreferences` (variable,value,options,explanation,type) VALUES ('OrderPdfFormat','pdfformat::layout3pages','Controls what script is used for printing (basketgroups)','','free');
INSERT INTO `systempreferences` (variable,value,options,explanation,type)  VALUES ('CurrencyFormat','US','US|FR','Determines the display format of currencies. eg: \'36000\' is displayed as \'360 000,00\'  in \'FR\' or \'360,000.00\'  in \'US\'.','Choice');
INSERT INTO `systempreferences` (variable,value,options,explanation,type) VALUES ('AcqCreateItem','ordering','ordering|receiving|cataloguing','Define when the item is created : when ordering, when receiving, or in cataloguing module','Choice');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('SyndeticsClientCode', '0', 'Client Code for using Syndetics Solutions content','','free');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('SyndeticsEnabled', '0', 'Turn on Syndetics Enhanced Content','','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('SyndeticsCoverImages', '0', 'Display Cover Images from Syndetics','','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('SyndeticsTOC', '0', 'Display Table of Content information from Syndetics','','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('SyndeticsSummary', '0', 'Display Summary Information from Syndetics','','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('SyndeticsEditions', '0', 'Display Editions from Syndetics','','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('SyndeticsExcerpt', '0', 'Display Excerpts and first chapters on OPAC from Syndetics','','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('SyndeticsReviews', '0', 'Display Reviews on OPAC from Syndetics','','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('SyndeticsAuthorNotes', '0', 'Display Notes about the Author on OPAC from Syndetics','','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('SyndeticsAwards', '0', 'Display Awards on OPAC from Syndetics','','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('SyndeticsSeries', '0', 'Display Series information on OPAC from Syndetics','','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('SyndeticsCoverImageSize', 'MC', 'Choose the size of the Syndetics Cover Image to display on the OPAC detail page, MC is Medium, LC is Large','MC|LC','Choice');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('OPACAmazonReviews', '0', 'Display Amazon readers reviews on OPAC','','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('OPACShowCheckoutName','0','Displays in the OPAC the name of patron who has checked out the material. WARNING: Most sites should leave this off. It is intended for corporate or special sites which need to track who has the item.','','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type)VALUES('LibraryThingForLibrariesID','','See:http://librarything.com/forlibraries/','','free');
INSERT INTO systempreferences (variable,value,explanation,options,type)VALUES('LibraryThingForLibrariesEnabled','0','Enable or Disable Library Thing for Libraries Features','','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type)VALUES('LibraryThingForLibrariesTabbedView','0','Put LibraryThingForLibraries Content in Tabs.','','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type)VALUES('FilterBeforeOverdueReport','0','Do not run overdue report until filter selected','','YesNo');
INSERT INTO systempreferences (variable,value,options,explanation,type)VALUES('SpineLabelFormat', '<itemcallnumber><copynumber>', '30|10', 'This preference defines the format for the quick spine label printer. Just list the fields you would like to see in the order you would like to see them, surrounded by <>, for example <itemcallnumber>.', 'Textarea');
INSERT INTO systempreferences (variable,value,options,explanation,type)VALUES('SpineLabelAutoPrint', '0', '', 'If this setting is turned on, a print dialog will automatically pop up for the quick spine label printer.', 'YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('OPACFineNoRenewals','100','Fine limit above which user cannot renew books via OPAC','','Integer');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('OverdueNoticeBcc','','Email address to bcc outgoing overdue notices sent by email','','free');
INSERT INTO systempreferences (variable,value,options,explanation,type)VALUES('HidePatronName', '0', '', 'If this is switched on, patron''s cardnumber will be shown instead of their name on the holds and catalog screens', 'YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('OPACSearchForTitleIn','<li><a  href="http://worldcat.org/search?q={TITLE}" target="_blank">Other Libraries (WorldCat)</a></li>\n<li><a href="http://www.scholar.google.com/scholar?q={TITLE}" target="_blank">Other Databases (Google Scholar)</a></li>\n<li><a href="http://www.bookfinder.com/search/?author={AUTHOR}&amp;title={TITLE}&amp;st=xl&amp;ac=qr" target="_blank">Online Stores (Bookfinder.com)</a></li>','Enter the HTML that will appear in the \'Search for this title in\' box on the detail page in the OPAC.  Enter {TITLE}, {AUTHOR}, or {ISBN} in place of their respective variables in the URL. Leave blank to disable \'More Searches\' menu.','70|10','Textarea');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('OPACMySummaryHTML','','Enter the HTML that will appear in a column on the \'my profile\' tab when a user is logged in to the OPAC. Enter {BIBLIONUMBER}, {TITLE}, {AUTHOR}, or {ISBN} in place of their respective variables in the HTML. Leave blank to disable.','70|10','Textarea');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('OPACPatronDetails','1','If OFF the patron details tab in the OPAC is disabled.','','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('OPACFinesTab','1','If OFF the patron fines tab in the OPAC is disabled.','','YesNo');
INSERT INTO systempreferences (variable,value,options,explanation,type)VALUES('DisplayOPACiconsXSLT', '1', '', 'If ON, displays the format, audience, type icons in XSLT MARC21 results and display pages.', 'YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES('AllowAllMessageDeletion','0','Allow any Library to delete any message','','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type)VALUES('ShowPatronImageInWebBasedSelfCheck', '0', 'If ON, displays patron image when a patron uses web-based self-checkout', '', 'YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('EnableOpacSearchHistory', '1', 'Enable or disable opac search history', 'YesNo','');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('RoutingListAddReserves','1','If ON the patrons on routing lists are automatically added to holds on the issue.','','YesNo');
INSERT INTO systempreferences VALUES ('ImageLimit',5,'','Limit images stored in the database by the Patron Card image manager to this number.','Integer');
INSERT INTO `systempreferences` (variable,value,options,explanation,type) VALUES ('SpineLabelShowPrintOnBibDetails', '0', '', 'If turned on, a "Print Label" link will appear for each item on the bib details page in the staff interface.', 'YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type)VALUES('AutoSelfCheckAllowed', '0', 'For corporate and special libraries which want web-based self-check available from any PC without the need for a manual staff login. Most libraries will want to leave this turned off. If on, requires self-check ID and password to be entered in AutoSelfCheckID and AutoSelfCheckPass sysprefs.', '', 'YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('AutoSelfCheckID','','Staff ID with circulation rights to be used for automatic web-based self-check. Only applies if AutoSelfCheckAllowed syspref is turned on.','','free');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('AutoSelfCheckPass','','Password to be used for automatic web-based self-check. Only applies if AutoSelfCheckAllowed syspref is turned on.','','free');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('soundon','0','Enable circulation sounds during checkin and checkout in the staff interface.  Not supported by all web browsers yet.','','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('UseTablesortForCirc','0','If on, use the JQuery tablesort function on the list of current borrower checkouts on the circulation page.  Note that the use of this function may slow down circ for patrons with may checkouts.','','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('ILS-DI','0','Enables ILS-DI services at OPAC.','','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('ILS-DI:AuthorizedIPs','','.','Restricts usage of ILS-DI to some IPs','Free');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('OverduesBlockCirc','noblock','When checking out an item should overdues block checkout, generate a confirmation dialogue, or allow checkout','noblock|confirmation|block','Choice');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('DisplayMultiPlaceHold','1','Display the ability to place multiple holds or not','','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES('IntranetUserCSS','','Add CSS to be included in the intranet in an embedded <style> tag.',NULL,'free');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES('OPACNoResultsFound','','Display this HTML when no results are found for a search in the OPAC','70|10','Textare    a');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES('OpacPublic',1,'Turn on/off public OPAC',NULL,'YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('ShelfBrowserUsesLocation','1','Use the item location when finding items for the shelf browser.','1','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('ShelfBrowserUsesHomeBranch','1','Use the item home branch when finding items for the shelf browser.','1','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('ShelfBrowserUsesCcode','1','Use the item collection code when finding items for the shelf browser.','0','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('AllowFineOverride','0','If on, staff will be able to issue books to patrons with fines greater than noissuescharge.','0','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('AllFinesNeedOverride','1','If on, staff will be asked to override every fine, even if it is below noissuescharge.','0','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('AuthoritiesLog','0','If ON, log edit/create/delete actions on authorities.','','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('TraceCompleteSubfields','0','Force subject tracings to only match complete subfields.','0','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('UseAuthoritiesForTracings','1','Use authority record numbers for subject tracings instead of heading strings.','0','YesNo');
INSERT INTO systempreferences (variable,value,explanation,options,type)   VALUES ('OPACAllowUserToChooseBranch', 1,       'Allow the user to choose the branch they want to pickup their hold from','1','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('displayFacetCount', '0', NULL, NULL, 'YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('maxRecordsForFacets', '20', NULL, NULL, 'Integer');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('AllowPurchaseSuggestionBranchChoice', 0, 'Allow user to choose branch when making a purchase suggestion','1','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('OpacFavicon','','Enter a complete URL to an image to replace the default Koha favicon on the OPAC','','free');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('IntranetFavicon','','Enter a complete URL to an image to replace the default Koha favicon on the Staff client','','free');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('TraceSubjectSubdivisions', '0', 'Create searches on all subdivisions for subject tracings.','1','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('StaffAuthorisedValueImages','1','',NULL,'YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('OPACDisplay856uAsImage','OFF','Display the URI in the 856u field as an image, the corresponding OPACXSLT option must be on','OFF|Details|Results|Both','Choice');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('Display856uAsImage','OFF','Display the URI in the 856u field as an image, the corresponding Staff Client XSLT option must be on','OFF|Details|Results|Both','Choice');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('AlternateHoldingsField','','The MARC field/subfield that contains alternate holdings information for bibs taht do not have items attached (e.g. 852abchi for libraries converting from MARC Magician).',NULL,'free');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES('AlternateHoldingsSeparator','','The string to use to separate subfields in alternate holdings displays.',NULL,'free');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES('OpacHiddenItems','','This syspref allows to define custom rules for hiding specific items at opac. See docs/opac/O    pacHiddenItems.txt for more informations.','','Textarea');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES('numSearchRSSResults',50,'Specify the maximum number of results to display on a RSS page of results',NULL,'Integer');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES ('OpacRenewalBranch','checkoutbranch','Choose how the branch for an OPAC renewal is recorded in statistics','itemhomebranch|patronhomebranch|checkoutbranch|null','Choice');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('BasketConfirmations', '1', 'When closing or reopening a basket,', 'always ask for confirmation.|do not ask for confirmation.', 'Choice');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('MARCAuthorityControlField008', '|| aca||aabn           | a|a     d', NULL, NULL, 'Textarea');
INSERT INTO systempreferences (variable,value,explanation,options,type) VALUES('OpenLibraryCovers',0, 'If ON Openlibrary book covers will be show',NULL,'YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('CheckValueIndicators','0','Check the values of the indicators in cataloguing','','YesNo');
INSERT INTO `systempreferences` (variable,value,explanation,options,type) VALUES ('DisplayPluginValueIndicators','0','Display a plugin with the correct values of indicators for fields in cataloguing','','YesNo');

