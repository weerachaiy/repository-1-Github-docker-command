# Docker-Commands

#### แสดงรายการ image ที่อยู่ในเครื่องเรา
```
docker images
```
#### สั่งลบ image ที่อยู่ในเครื่องเรา
```
Command : docker rmi {image_id} หรือ {image_name} 
Example : docker rmi 29a462eea79c
```

#### ทำการลบ image ทั้งหมดในเครื่องเรา
```
Command : docker images | grep "search_pattern" | awk '{print $3}' | xargs -I{} docker rmi {}
Example : docker images | grep "none" | awk '{print $3}' | xargs -I{} docker rmi {}
```

#### แสดงรายการ container ที่อยู่ในเครื่องเรา 
```
docker ps -a
```

#### สั่ง run container 
```
docker run -it -v {/path/to/your/project/directory/or/home/directory}:{docker/container/path/} -p 9012:9012 --name {desired_container_name(Optional)} {image_name} {Command}
```

#### สั่ง start container ที่จบการทำงานไปแล้ว

แสดงรายการ container ที่อยู่ในเครื่องเรา
```
docker ps -a
```

หา CONTAINER ID 
```
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                    PORTS                              NAMES
29a462eea79c        ubuntu          "/bin/bash"         4 days ago          Exited (255) 3 days ago   0.0.0.0:9010-9012->9010-9012/tcp   ubuntu
```

ใช้ CONTAINER ID สั่ง start container
```
docker start 29a462eea79c
```

#### เข้าถึง container ด้วย CONTAINER ID
```
docker attach 29a462eea79c
```

#### สั่งหยุด container ด้วย CONTAINER ID
```
docker stop 29a462eea79c
```

#### ทำการลบ container ด้วย CONTAINER ID
```
docker rm 29a462eea79c
```

#### ทำการลบ container ทั้งหมดในเครื่องเรา
```
Command : docker ps -a | grep "search_pattern" | awk '{print $1}' | xargs -I{} docker rm {}
Example : docker ps -a | grep "Exited" | awk '{print $1}' | xargs -I{} docker rm {}
```

สร้าง Dockerfile

สร้างไฟล์ชื่อ ``Dockerfile``  ใน VSC
```
# เริ่มจาก FROM นำ image ต้องการ Ubuntu 18.04
FROM ubuntu:18.04

# กำหนดชื่อคนดูแลไฟล์ Dockerfile ด้วย MAINTAINER
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
```

#### สร้าง docker image จาก Dockerfile
```
docker build --no-cache -t python .
```

#### สั้งทำงาน python ที่ Port 5000
```
docker run -p 5000:5000 --name python python
```

#### ทำการลบ container และ image ทั้งหมดในเครื่องเรา
```
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
```

#### เข้าถึง shell ใน container 
```
docker exec -it <container_name/container_id> bash
```

#### เหมือนตำสั่ง top ใน Linux
```
docker top <container_name/container_id>
```

#### ดูสถานะของ container  
```
docker stats <container_name/container_id>
```


