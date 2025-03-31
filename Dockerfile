FROM pytorch/pytorch:2.3.0-cuda12.1-cudnn8-runtime
#FROM pytorch/pytorch:2.6.0-cuda12.4-cudnn9-runtime

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
	libgl1 \
	libglib2.0-0 \
	python3 \
	python3-venv \
	git \
	wget \
	vim \
	inetutils-ping \
	sudo \
	net-tools \
	iproute2 && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/comfyanonymous/ComfyUI.git /ComfyUI 
WORKDIR "/ComfyUI"

# setup venv in /venv to avoid conflict with volume in /stable-diffusion-webui
#RUN echo 'venv_dir=/venv' > webui-user.sh

#RUN ./webui.sh -f can_run_as_root --xformers --exit --skip-torch-cuda-test
RUN python -m venv /venv && pip install -r requirements.txt 

#ENV VIRTUAL_ENV=/venv
#ENV PATH="$VIRTUAL_ENV/bin:$PATH"

CMD ["python3", "launch.py", "--listen", "--xformers"]
