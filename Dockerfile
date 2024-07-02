# 使用官方的Ruby镜像作为基础镜像
FROM ruby:3.1

# 设置工作目录
WORKDIR /app

# 将Gemfile和Gemfile.lock拷贝到容器中
COPY Gemfile Gemfile.lock ./

# 安装系统级别的依赖项（例如，Jekyll需要的一些C扩展）
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    python3 \
    python3-pip \
    libxml2-dev \
    libxslt-dev \
    libffi-dev \
    libyaml-dev \
    libgdbm-dev \
    libncurses5-dev \
    libbz2-dev \
    libreadline-dev \
    zlib1g-dev \
    curl \
    && apt-get clean

# 安装Ruby gems，包括Jekyll及其依赖
RUN gem install bundler && \
    bundle install

# 将应用的源代码拷贝到容器中
COPY . .

# 设置Jekyll在生产模式下运行
ENV JEKYLL_ENV=production

# 暴露端口，通常Jekyll使用的是4000端口
EXPOSE 4000

# 设置容器启动时执行的命令
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]