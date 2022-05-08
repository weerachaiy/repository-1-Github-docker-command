# เริ่มจาก FROM นำ image ต้องการ Ubuntu 18.04
FROM ubuntu:18.04

# กำหนดชื่อคนดูแลไฟล์ ``Dockerfile`` ด้วย MAINTAINER
MAINTAINER weerachaiy

# สั่ง RUN update Ubuntu และติดตั้ง tool ที่เราต้องใช้
RUN apt-get update \
	&& apt-get install -my wget gnupg \
	&& apt-get install -y --no-install-recommends \
		apt-utils \
		ca-certificates \
		apt-transport-https \
		jq \
		numactl \
&& rm -rf /var/lib/apt/lists/*

RUN apt-get update

# ติดตั้ง python ที่เราต้องการ
RUN apt-get install -y python-pip python-dev build-essential

# copy โฟลเดอร์ flask_webapp ของเรา ไปที่ /app ใน container
COPY flask_webapp/ /app

# กำหนด ที่ตั้งปัจจุบีน ด้วย WORKDIR (เหมือน CD ใน Linux)
WORKDIR /app

# ติดตั้ง tool ต่างๆ ตาม requirements.txt ใน /app
RUN pip install -r requirements.txt

# สั่ง python ทำงาน ด้วย ENTRYPOINT
ENTRYPOINT ["python"]

# สั่ง app.py ทำงาน ด้วย CMD
CMD ["app.py"]
