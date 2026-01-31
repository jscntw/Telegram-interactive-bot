FROM python:3.10.14-alpine

# 复制依赖文件
COPY ./requirements.txt /tmp/requirements.txt

# 安装编译所需的依赖，安装 Python 包，最后清理编译依赖以减小镜像体积
RUN apk add --no-cache --virtual .build-deps \
    gcc \
    musl-dev \
    libffi-dev \
    python3-dev \
    && pip install --no-cache-dir -r /tmp/requirements.txt \
    && apk del .build-deps

# 设置工作目录
WORKDIR /app

# 注意：这里需要把当前目录的代码复制到容器的 /app 目录
COPY . /app

# 保持你原有的启动命令
CMD ["python", "-m", "interactive-bot"]

