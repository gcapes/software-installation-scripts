#!/bin/bash -e



year=2016
month=06
day=10

# set the extract date
dayget=`date -d "$year$month$day - 1 day" +%d`
monthget=`date -d "$year$month$day - 1 day" +%m`
yearget=`date  -d "$year$month$day - 1 day" +%Y`

# set the middle date
daytom=`date -d "$year$month$day + 1 day" +%d`
monthtom=`date -d "$year$month$day + 1 day" +%m`
yeartom=`date  -d "$year$month$day + 1 day" +%Y`



## emission linking
origfilea=wrfchemi_d01_$yearget-$monthget-${dayget}_00:00:00
origfileb=wrfchemi_d01_$year-$month-${day}_00:00:00
origfilec=wrfchemi_d01_$yeartom-$monthtom-${daytom}_00:00:00

for timevalue in {1..23}
do
	# create time string
	if [ $timevalue -lt 10 ]; then
	timestring=0$timevalue
	else
	timestring=$timevalue
    fi

	newfilea=wrfchemi_d01_$yearget-$monthget-${dayget}_$timestring:00:00
	newfileb=wrfchemi_d01_$year-$month-${day}_$timestring:00:00
	newfilec=wrfchemi_d01_$yeartom-$monthtom-${daytom}_$timestring:00:00

	ln -s $origfilea $newfilea
	ln -s $origfileb $newfileb
	ln -s $origfilec $newfilec
done
