FROM --platform=${BUILDPLATFORM:-linux/amd64} ghcr.io/epicgames/unreal-engine:dev-4.27 AS builder

# COPY --chown=ue4:ue4 . /project


# Clone the source code for the example Unreal project
RUN git clone --progress --depth=1 'https://gitlab.com/ue4-test-projects/4.26/firstpersoncxx.git' /tmp/project

# Enable the Pixel Streaming plugin in the example Unreal project
RUN sed -i 's|"Modules"|"Plugins": [{"Name": "PixelStreaming", "Enabled": true}],\n\t"Modules"|' /tmp/project/FirstPersonCxx.uproject

# Package the example Unreal project
RUN /home/ue4/UnrealEngine/Engine/Build/BatchFiles/RunUAT.sh BuildCookRun \
	-clientconfig=Development -serverconfig=Development \
	-project=/tmp/project/FirstPersonCxx.uproject \
	-utf8output -nodebuginfo -allmaps -noP4 -cook -build -stage -prereqs -pak -archive \
	-archivedirectory=/tmp/project/dist \
	-platform=Linux

# Copy the packaged project into the Pixel Streaming runtime image
FROM --platform=${BUILDPLATFORM:-linux/amd64} ghcr.io/epicgames/unreal-engine:runtime-pixel-streaming
COPY --from=builder --chown=ue4:ue4 /tmp/project/dist/Linux /home/ue4/project




# WORKDIR  /project

# RUN /home/ue4/UnrealEngine/Engine/Build/BatchFiles/RunUAT.sh \
#     BuildCookRun \
#     -utf8output \
#     -platform=Linux \
#     -clientconfig=Shipping \
#     -serverconfig=Shipping \
#     -project=/project/MyDemoProject.uproject \
#     -noP4 -nodebuginfo -allmaps \
#     -cook -build -stage -prereqs -pak -archive \
#     -archivedirectory=/project/Packaged 

# FROM --platform=${BUILDPLATFORM:-linux/amd64} ghcr.io/epicgames/unreal-engine:runtime-pixel-streaming
# WORKDIR /home/ue4/project
# COPY --from=build --chown=ue4:ue4 /project/Packaged/LinuxNoEditor ./

# More Configs: https://docs.unrealengine.com/4.27/en-US/SharingAndReleasing/PixelStreaming/PixelStreamingReference/
CMD ["/bin/bash", "-c", "/home/ue4/project/FirstPersonCxx.sh -PixelStreamingURL=${SIGNALSERVER_URL} -RenderOffscreen -Unattended -ResX=1920 -ResY=1080 -Windowed -ForceRes -StdOut" ]
