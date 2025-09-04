# Dino Chrome (Dino_Chrome_gds)

Phiên bản mô phỏng trò chơi "Dinosaur" của Chrome, được triển khai bằng HTML/CSS/JavaScript.

Mục đích: dự án này là một bản sao (hoặc cải tiến nhỏ) của trò chơi Dino trong Google Chrome, dùng để học tập và thực hành JavaScript game đơn giản.

---

## Nội dung chính

- index.html: trang chính chạy trò chơi.
- css/: chứa các tệp CSS (nếu có).
- js/: chứa mã JavaScript chính của trò chơi.
- assets/: hình ảnh, âm thanh, và tài nguyên khác.

> Lưu ý: Cấu trúc thư mục có thể khác với repo hiện tại; hãy kiểm tra lại nếu cần.

---

## Tính năng

- Nhảy để tránh chướng ngại vật (cactus).
- Hạ thấp/né (nếu được hỗ trợ).
- Điểm số tăng theo thời gian.
- Giao diện đơn giản, dễ hiểu.
- Hỗ trợ phím bấm và chạm (mobile).

---

## Yêu cầu

- Trình duyệt hiện đại (Chrome, Edge, Firefox, Safari).
- Node.js (chỉ nếu bạn muốn chạy server phát triển hoặc build). Không bắt buộc nếu chỉ mở tệp HTML trực tiếp.

---

## Chạy nhanh (không cài đặt)

1. Clone repo:

   git clone https://github.com/NguyenMinhNghia-2004/Dino_Chrome_gds.git
   cd Dino_Chrome_gds

2. Mở `index.html` bằng trình duyệt (kéo thả hoặc chuột phải -> Open with...)

Hoặc khởi chạy server tĩnh (được khuyến nghị để tránh một số hạn chế trình duyệt):

- Dùng Python 3:

  python -m http.server 8000

  rồi truy cập http://localhost:8000

- Hoặc dùng live-server (npm):

  npm install -g live-server
  live-server

---

## Hướng dẫn chơi

- Phím Space / Mũi tên Lên: Nhảy.
- Phím Mũi tên Xuống: Hạ thấp (nếu được hỗ trợ).
- Chạm vào màn hình trên thiết bị di động để nhảy.
- Tránh chạm vào chướng ngại vật; trò chơi kết thúc khi va chạm.

---

## Tùy chỉnh & Phát triển

- Thêm chướng ngại vật mới, thay đổi tốc độ hoặc thêm mức độ khó.
- Thêm âm thanh khi nhảy/va chạm.
- Lưu điểm số cao bằng localStorage.
- Nếu dùng bundler (Webpack/Vite), cấu hình build tương ứng và thêm hướng dẫn trong README.

---

## Cấu trúc gợi ý

```
Dino_Chrome_gds/
├─ index.html
├─ css/
│  └─ styles.css
├─ js/
│  └─ game.js
├─ assets/
│  ├─ sprite.png
│  └─ jump.wav
└─ README.md
```

---

## Đóng góp

Mọi đóng góp đều được hoan nghênh:
- Tạo pull request để thêm tính năng hoặc sửa lỗi.
- Mở issue để báo lỗi hoặc đề xuất cải tiến.

---

## Bản quyền

Bản quyền (c) 2025 NguyenMinhNghia-2004. Sử dụng theo giấy phép MIT (hoặc thay đổi theo ý bạn).

Nếu bạn muốn mình đặt một license cụ thể, hãy cho biết.