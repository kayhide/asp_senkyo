cat adad.txt | grep . | sort | uniq -c | sort -n -k1 -r > count.txt
