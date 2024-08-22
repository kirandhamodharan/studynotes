for i in {1..24}; 
do
    echo $i
    ping -c1 www.google.com &> /dev/null && break;
    sleep 5
done