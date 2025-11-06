# chrome-base.dockerfile
# 基础镜像：Demo Harbor 里的官方 Python 3.9 slim
FROM demo.goharbor.io/library/python:3.9-slim

# 安装 Chrome 依赖（无推荐包，减小体积）
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      libnss3 \
      libxss1 \
      libasound2 \
      libxtst6 \
      libgtk-3-0 \
      libgbm1 && \
    rm -rf /var/lib/apt/lists/*

# 拷贝离线浏览器 & 驱动（构建上下文必须存在）
COPY deps/chrome /opt/google/chrome/chrome
COPY deps/chromedriver /usr/local/bin/chromedriver

# 赋可执行权限
RUN chmod +x /opt/google/chrome/chrome /usr/local/bin/chromedriver

# 把 Chrome 目录加入 PATH，方便后面直接调用
ENV PATH="/opt/google/chrome:${PATH}"

# 默认工作目录 & 启动命令（业务镜像可覆盖）
WORKDIR /app