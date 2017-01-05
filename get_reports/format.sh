if [ $1 ]; then
	
	# check if dir to store cookie reports exists
	# if not then create it

	if ! [ -d cookie_reports ]; then
	  	mkdir -m 777 cookie_reports
	fi

	# clear original DIR
	rm -rf cookie_reports/*
	
	# get date attributes

	month=`date +%b`
	day=`date +%d`
	day=`expr $day - 1`
	year=`date +%Y`


	# now check if dated folder exists
	# if not create

	DIR=$month"_"$day"_"$year

	if ! [ -d cookie_reports/$DIR ]; then
	  	mkdir -m 777 cookie_reports/$DIR
	fi

	value='{"startDate": "'$month' '$day' '$year' 00:00:00 GMT+0530 (India Standard Time)", "endDate": "'$month' '$day' '$year' 23:59:59 GMT+0530 (India Standard Time)"}'
	
	# value='{"startDate": "Dec 25 2016 00:00:00 GMT+0530 (India Standard Time)", "endDate": "Dec 25 2016 00:59:59 GMT+0530 (India Standard Time)"}'

	echo '+--------------------------------+\n| Saving report-'$1' for '$month $day $year' |\n+--------------------------------+\n'

	# make curl request and save to file

	curl -H "Content-Type: application/json" -d "$value" http://localhost:1337/export/format"$1" -o cookie_reports/$DIR/$month"_"$day"_"$year"_format_"$1.csv

	# move to /var/www/html/cookie_reports DIR

	if ! [ -d /var/www/html/cookie_reports ]; then
	  	mkdir -m 777 /var/www/html/cookie_reports
	fi

	if ! [ -d /var/www/html/cookie_reports/$DIR ]; then  	
	  	mkdir -m 777 /var/www/html/cookie_reports/$DIR
	fi

	cp cookie_reports/$DIR/$month"_"$day"_"$year"_format_"$1.csv /var/www/html/cookie_reports/$DIR
	
fi