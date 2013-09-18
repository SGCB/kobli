<div id="advsearch">
    <form action="/cgi-bin/koha/serials/serials-search.pl" method="get">
        <fieldset class="brief">
            <a id="unfold_advsearch" style="cursor:pointer" onclick="$('#advsearch_form').slideToggle(400);">Advanced search</a>
            <div id="advsearch_form" style="display:none">
            <ol>
                <li>
                  <label for="issn">ISSN:</label>
                  <input type="text" id="issn" name="ISSN_filter" value="[% ISSN_filter %]" />
                </li>
                <li>
                  <label for="title">Title:</label>
                  <input type="text" id="title" name="title_filter" value="[% title_filter %]" />
                </li>
                [% IF ( marcflavour == "UNIMARC" ) %]
                <li>
                  <label for="ean">EAN:</label>
                  <input type="text" id="ean" name="EAN_filter" value="[% EAN_filter %]" />
                </li>
                [% END %]
                <li>
                  <label for="callnumber">Callnumber:</label>
                  <input type="text" id="callnumber" name="callnumber_filter" value="[% callnumber_filter %]" />
                </li>
                <li>
                  <label for="publisher">Publisher:</label>
                  <input type="text" id="publisher" name="publisher_filter" value="[% publisher_filter %]" />
                </li>
                <li>
                  <label for="bookseller">Vendor:</label>
                  <input type="text" id="bookseller" name="bookseller_filter" value="[% bookseller_filter %]" />
                </li>
                <li>
                  <label for="branch">Library:</label>
                  <select id="branch" name="branch_filter">
                    <option value="">All</option>
                    [% FOREACH branch IN branches_loop %]
                      [% IF ( branch.selected ) %]
                        <option selected="selected" value="[% branch.branchcode %]">[% branch.branchname %]</option>
                      [% ELSE %]
                        <option value="[% branch.branchcode %]">[% branch.branchname %]</option>
                      [% END %]
                    [% END %]
                  </select>
                </li>
                [% IF locations %]
                  <li>
                    <label for="location">Location:</label>
                    <select name="location_filter">
                      <option value="">All</option>
                      [% FOR loc IN locations %]
                        [% IF loc.selected %]
                          <option value="[% loc.authorised_value %]" selected="selected">[% loc.lib %]</option>
                        [% ELSE %]
                          <option value="[% loc.authorised_value %]">[% loc.lib %]</option>
                        [% END %]
                      [% END %]
                    </select>
                  </li>
                [% END %]
                <li>
                  <label for="to">Expiration date:</label>
                  <input type="text" id="to" name="expiration_date_filter" value="[% expiration_date_filter | $KohaDates %]" size="10" maxlength="10" class="datepickerto" />
                </li>
              </ol>
            <input type="hidden" name="searched" value="1" />
            [% IF (booksellerid) %]
                <input type="hidden" name="booksellerid" value="[% booksellerid %]" />
            [% END %]
            [% IF (basketno) %]
                <input type="hidden" name="basketno" value="[% basketno %]" />
            [% END %]
            <fieldset class="action">
              <input type="submit" value="Search" />
            </fieldset>
            </div>
        </fieldset>
    </form>
</div>
