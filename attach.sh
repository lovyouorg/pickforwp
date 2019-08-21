#!/bin/bash
arr=(6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61)
#arr=(5)
for a in ${arr[*]}
do
 cd /mnt/www/gif/$a
 awk -F "/" '{print $5}' url1.txt >url2.txt
 sed 's/^/<a href="http:\/\/v2.${url}.com\/gif\/'$a'\/&/g' url2.txt >url4.txt
 sed 's/$/&">/g' url4.txt >url5.txt
 sed 's/^/<img class="alignnone" src="http:\/\/v2.${url}.com\/gif\/'$a'\/&/g' url2.txt >url3.txt
 sed 's/$/&" alt="gif" height="300" \/><\/a>/g' url3.txt >url6.txt
 paste url5.txt url6.txt>url7.txt
 sed '1i\<a href="http://v2.${url}.com/gif/tump/'$a'.jpg"><img class="alignnone" src="http://v2.${url}.com/gif/tump/'$a'.jpg" alt="gif" height="300" /></a>' url7.txt>url8.txt 
 b=`cat url8.txt`
 echo "INSERT INTO wordpress.wp_posts (post_author, post_date, post_date_gmt, post_content, post_title, post_excerpt, post_status, comment_status, ping_status, post_password, post_name, to_ping, pinged, post_modified, post_modified_gmt, post_content_filtered, post_parent, guid, menu_order, post_type, post_mime_type, comment_count) VALUES ('1',now(),now(), '', 'gif$a', '', 'publish', 'open', 'open', '', 'gif$a', '', '',now(),now(), '', '0','aaa', '0', 'post', '', '0');" >insert.sql
 echo "update wordpress.wp_posts set guid = concat(\"http://www.${url}.com/?p=\",id) where guid='aaa';" >>insert.sql
 echo "update wordpress.wp_posts set post_content='$b' where post_name='gif$a';" >>insert.sql
 echo "INSERT INTO wordpress.wp_term_relationships (object_id, term_taxonomy_id, term_order) VALUES ((select id from wordpress.wp_posts where post_name='gif$a'), '15', '0');" >>insert.sql
 echo "INSERT INTO wordpress.wp_term_relationships (object_id, term_taxonomy_id, term_order) VALUES ((select id from wordpress.wp_posts where post_name='gif$a'), '16', '0');" >>insert.sql
 mysql -h${mysqlhost} -P86 -uroot -p${password} -e "source insert.sql"
done
