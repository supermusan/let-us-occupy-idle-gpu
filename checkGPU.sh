var=0
memory=6500
sleep_time=600
while [ $var -eq 0 ]
do
    count=0
    for i in $(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits)
    do
        if [ $count -eq 3 ] || [ $count -eq 0 ]
        then
            count=$(($count+1))
            continue
        fi

        if [ $i -lt $memory ]
        then
            echo $(date +"%Y-%m-%d %T") ' GPU'$count' is avaiable'
            # 隔一段时间再检测，保证确实没人使用

            sleep $sleep_time
            if [ ! $i -lt $memory ]
            then
                echo $(date +"%Y-%m-%d %T") ' GPU'$count' is not available' $i
                count=$(($count+1))
                 break
            fi
            echo $(date +"%Y-%m-%d %T") ' GPU'$count' is still available'

            sleep $sleep_time
            if [ ! $i -lt $memory ]
            then
                echo $(date +"%Y-%m-%d %T") ' GPU'$count' is not available' $i
                count=$(($count+1))
                break
            fi
            echo $(date +"%Y-%m-%d %T") ' GPU'$count' is still available'

            sleep $sleep_time
            if [ ! $i -lt $memory ]
            then
                echo $(date +"%Y-%m-%d %T") ' GPU'$count' is not available' $i
                count=$(($count+1))
                break
            fi
            echo $(date +"%Y-%m-%d %T") ' GPU'$count' is still available'

            echo $(date +"%Y-%m-%d %T") ' Run!!!'
            # run script 
            # CUDA_VISIBLE_DEVICES=$count python run.py --config config/xxx.yaml --device_ids 0
            var=1
            break
        fi
        echo $(date +"%Y-%m-%d %T") ' GPU'$count' is not available' $i
        count=$(($count+1))
        sleep 1
    done
done