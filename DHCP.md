
# DHCP
DHCP là viết tắt của Dynamic Host Configuration Protocol:

Giao thức Cấu hình Host Động DHCP được thiết kế làm giảm thời gian chỉnh cấu hình cho mạng TCP/IP bằng cách tự động gán các địa chỉ IP cho khách hàng khi họ vào mạng.

DHCP tập trung việc quản lý địa chỉ IP ở các máy tính trung tâm chạy chương trình DHCP. Mặc dù có thể gán địa chỉ IP vĩnh viễn cho bất cứ máy tính nào trên mạng, DHCP cho phép gán tự động. Để khách có thể nhận địa chỉ IP từ máy chủ DHCP, bạn khai báo cấu hình để khách “nhận địa chỉ tự động từ một máy chủ”. Tùy chọn nầy xuất hiện trong vùng khai báo cấu hình TCP/IP của đa số hệ điều hành. Một khi tùy chọn nầy được thiết lập, khách có thể “thuê” một địa chỉ IP từ máy chủ DHCP bất cứ lúc nào. Phải có ít nhất một máy chủ DHCP trên mạng. Sau khi cài đặt DHCP, bạn tạo một phạm vi DHCP (scope), là vùng chứa các địa chỉ IP trên máy chủ, và máy chủ cung cấp địa chỉ IP trong vùng này

# Cài đặt và cấu hình DHCP
Mô hình triển khai 

<img src="http://i.imgur.com/CaHMm6I.png">

Trước hết chúng ta sử dung câu lệnh ``sudo apt-get install isc-dhcp-server`` để cài đặt dịch vụ DHCP

**note** để cài được dịch vụ DHCP phải có card NAT để chúng ta có thể tiến hành tải và cài đặt những repo cần thiết cho quá trình lab.

vào file cấu hình dhcpd.conf . Ở đây mình chọn địa chỉ cấp phát IP từ 10.10.10.10 đến 10.10.10.40

<img src="http://i.imgur.com/gNNZx8c.png">

Sau đó lưu file lại và khởi động dịch vụ DHCP bằng câu lệnh 

``sudo /etc/init.d/isc-dhcp-server start``


 Cuối cùng là kiểm tra máy client xem đã nhận được IP động chưa.

<img src="http://i.imgur.com/pSQLiQr.png">


Thông thường một máy chủ DHCP-server sẽ được cấu hình theo 2 phương pháp

- Vùng địa chỉ : Phương pháp này đòi hỏi phải xác định 1 vùng (Phạm Vi) của địa chỉ IP và DHCP cung cấp cho khách hàng của họ đang cấu hình và tính năng động trên một server cơ sở . Một khi DHCP client không còn trên mạng cho 1 khoảng thời gian xác định, cấu hình là hết hạn và khi trở lại sẽ được cấp phát địa chỉ mới bằng cách sử dụng các dịch vụ của DHCP.

- Địa chỉ MAC : Phương pháp này đòi hỏi phải sử dụng dịch vụ DHCP xác định địa chỉ phần cứng duy nhất của mỗi card mạng kết nối với các mạng lưới và sau đó liên tục cung cấp một cấu hình DHCP mỗi lần khách hàng yêu cầu để tạo ra một trình phục vụ DHCP bằng cách sử dụng các thiết bị mạng.

