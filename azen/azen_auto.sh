#!/usr/bin/env bash

#压测脚本设置的时间为120秒
export jmx_filename=azen.jmx

# 需要在系统变量中定义jmeter根目录的位置，如下
export jmeter_path=/Users/zhangdongdong/apache-jmeter-5.6.2

echo "自动化压测开始"
rm -f error_log.xml

# 压测并发数列表
thread_number_array=(10 20 30)
for number in "${thread_number_array[@]}"
do
    echo "压测并发数 ${number}"
    # 定义jtl结果和压测报告路径
    export jtl_filename="test_${number}.jtl"
    export web_report_path_name="web_${number}"

    rm -f ${jtl_filename}
    rm -rf ${web_report_path_name}

    # jmeter 静默压测 + 生成html压测报告
    #${jmeter_path}/bin/jmeter -n -t azen.jmx -l test_${number}.jtl -Jthread=${number} -e -o web_${number}
    ${jmeter_path}/bin/jmeter -n -t ${jmx_filename} -l ${jtl_filename} -Jthread=${number} -e -o ${web_report_path_name}
    echo "结束压测并发数 ${number}"
done
echo "自动压测全部结束"
