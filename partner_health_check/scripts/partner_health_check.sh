#!/bin/bash

partner_check_root="/home/ec2-user/partner_health_check"
partner_check_results="/home/ec2-user/partner_health_check/results"
partner_health_check_zip="partner_health_check.zip"
execute_collection_script=$partner_check_root"/execute_collection.sh"
sendmail_script=$partner_check_root"/sendmail.py"
collection_file='/home/ec2-user/partner_health_check/PARTNER_HEALTH_CHECK.postman_collection.json'


current_time=$(date "+%Y.%m.%d-%H.%M.%S")
echo "Start health script execution. Start time:" $current_time


find "$partner_check_results" -type f -name "*.html" -delete
find "$partner_check_root" -type f -name "*.zip" -delete

#path to execute newman collection script
#newman_script_path=$partner_check_root"/execute_collection.py"

echo "Execute Collection script location : " $execute_collection_script

#execute the postman collection
#python3 "$newman_script_path"
#sh $execute_collection_script

results_file=$partner_check_results'/health_check_report_'${current_time}'.html'

/home/ec2-user/nodejs/node-v20.10.0-linux-x64/bin/node /home/ec2-user/nodejs/node-v20.10.0-linux-x64/bin/newman run $collection_file -x -r htmlextra --reporter-htmlextra-export $results_file 

echo "*** -->" $?

#wait
#sleep 20

if [[ $? -ne 0 ]]; then
    echo "Error: Collection execution FAILED."
    echo "Exit status:" $?
    exit 1
fi


echo "Partner check results file : " $results_file

#if [ ! -d "$partner_check_results" ]; then
#if [ ! "$(ls -A $partner_check_results)" ]; then

#sleep 10

#if [ -e "$results_file" ]; then

counter=1
while [ $counter -le 1 ]
do
    #echo "Error: Results file '$results_file' not found."
    #echo "Exit status:" $?
    #exit 1
    #
    if [ -e "$results_file" ]; then
	echo "Result file yet to be generated"
	sleep 10
	((counter++))
    fi	    
done
#fi


echo "Archiving the health check result file"
cd $partner_check_root

/usr/bin/zip -j -r "$partner_health_check_zip" "$partner_check_results"

#/usr/bin/zip -r "partner_health_check.zip" "/home/ec2-user/partner_health_check/results"

echo "*** -->" $?

if [[ $? -ne 0 ]]; then
    echo "Error: Zip command FAILED."
    echo "Exit status:" $?
    exit 1
fi


echo "Send mail script : " $sendmail_script

#mail postman report
#python3 $sendmail_script 
/usr/bin/python3 /home/ec2-user/partner_health_check/sendmail.py

if [[ $? -ne 0 ]]; then
    echo "Error: Send mail FAILED."
    echo "Exit status:" $?
    exit 1
fi


current_time=$(date "+%Y.%m.%d-%H.%M.%S")
echo "Health check script execution completed successfully.End Time :" $current_time
