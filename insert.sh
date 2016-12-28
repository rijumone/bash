if ! [ -d /db_writes/visitor/add/failed ]; then
  	mkdir -m 777 failed
fi
if ! test -s $file /db_writes/visitor/add/job_running.flag
        then
                echo "1" >> /db_writes/visitor/add/job_running.flag
                for entry in /db_writes/visitor/add/*.json
                do
			echo "Processing $entry"
                        value=`cat "$entry"`
                		echo result=`curl -H "Content-Type: application/json" -d "$value" http://localhost/visitor/addtofile -vvv`
                     if [[ "$result" =~ "err" ]]; then
                                echo "failed; moving file"
                                mv $entry /db_writes/visitor/add/failed/
                        elif [[ "$result" =~ "invalid" ]]; then
                        	    echo "failed; moving file"
                                mv $entry /db_writes/visitor/add/failed/
						else
                                echo "deleting $entry"
                                rm -rf $entry
                        fi
done
                rm -rf /db_writes/visitor/add/job_running.flag
fi
