# Makefile template for building leadwerks projects
# -------------------------------------------------------------------------------
PROJECTNAME=MyProjectName
LEADWERKS=$(HOME)/.local/share/Steam/steamapps/common/Leadwerks
# -------------------------------------------------------------------------------

EXECUTABLE_RELEASE=$(PROJECTNAME)
EXECUTABLE_DEBUG=$(PROJECTNAME).debug

CC=clang
CFLAGS=-Wno-null-conversion \
-Wno-extern-c-compat \
-fexceptions \
-msse3 \
-DDG_DISABLE_ASSERT \
-DZLIB \
-DPLATFORM_LINUX \
-D_NEWTON_STATIC_LIB \
-DFT2_BUILD_LIBRARY \
-DOPENGL \
-Dunix \
-D_POSIX_VER \
-D_POSIX_VER_64 \
-DDG_THREAD_EMULATION \
-D_STATICLIB \
-DDG_USE_THREAD_EMULATION \
-DGL_GLEXT_PROTOTYPES \
-DLEADWERKS_3_1 \
-D_CUSTOM_JOINTS_STATIC_LIB

INCLUDEDIRS=-I$(LEADWERKS)/Include/Libraries/NewtonDynamics/coreLibrary_300/source/core \
-I$(LEADWERKS)/Include/Libraries/NewtonDynamics/coreLibrary_300/source/meshUtil \
-I$(LEADWERKS)/Include/Libraries/NewtonDynamics/coreLibrary_300/source/newton \
-I$(LEADWERKS)/Include/Libraries/NewtonDynamics/coreLibrary_300/source/physics \
-I$(LEADWERKS)/Include/Libraries/NewtonDynamics/packages/dMath \
-I$(LEADWERKS)/Include/Libraries/NewtonDynamics/packages/dContainers \
-I$(LEADWERKS)/Include/Libraries/NewtonDynamics/packages/dCustomJoints \
-I$(LEADWERKS)/Include/Libraries/tolua++-1.0.93/include \
-I$(LEADWERKS)/Include/Libraries/lua-5.1.4 \
-I$(LEADWERKS)/Include/Libraries/freetype-2.4.7/include \
-I$(LEADWERKS)/Include/Libraries/enet-1.3.1/include \
-I$(LEADWERKS)/Include/Libraries/RecastNavigation/DebugUtils/Include \
-I$(LEADWERKS)/Include/Libraries/RecastNavigation/Detour/Include \
-I$(LEADWERKS)/Include/Libraries/RecastNavigation/DetourCrowd/Include \
-I$(LEADWERKS)/Include/Libraries/RecastNavigation/DetourTileCache/Include \
-I$(LEADWERKS)/Include/Libraries/RecastNavigation/Recast/Include \
-I$(LEADWERKS)/Include \
-I$(LEADWERKS)/Include/Libraries/zlib-1.2.5 \
-I$(LEADWERKS)/Include/Libraries/zlib-1.2.5/contrib/minizip \
-I$(LEADWERKS)/Include/Libraries/freetype-2.4.7/include/freetype \
-I$(LEADWERKS)/Include/Libraries/freetype-2.4.7/include/freetype/config \
-I$(LEADWERKS)/Include/Libraries/LuaJIT/dynasm \
-I$(LEADWERKS)/Include/Libraries/glew-1.6.0/include \
-I$(LEADWERKS)/Include/Libraries/openal-soft/include

LDFLAGS=-L$(LEADWERKS)/Library/Linux -lluajit \
-lopenal -lGL -lGLU ./libsteam_api.so -lpthread -lX11

LDFLAGS_RELEASE=-L$(LEADWERKS)/Library/Linux/Release/ -l:Leadwerks.a -O2
LDFLAGS_DEBUG=-L$(LEADWERKS)/Library/Linux/Debug/ -l:Leadwerks.a -g -DDEBUG -D_DEBUG

SOURCES=$(shell find ./Source -iname "*.cpp")

OBJECTS=$(SOURCES:.cpp=.o)

all: $(EXECUTABLE_RELEASE) $(EXECUTABLE_DEBUG)

$(EXECUTABLE_RELEASE): $(OBJECTS)
	$(CC) $(OBJECTS) $(LDFLAGS) $(LDFLAGS_RELEASE) -o $@

$(EXECUTABLE_DEBUG): $(OBJECTS)
	$(CC) $(OBJECTS) $(LDFLAGS) $(LDFLAGS_DEBUG) -o $@

.cpp.o:
	$(CC) -c $(CFLAGS) $(INCLUDEDIRS) $< -o $@

clean:
	-rm $(EXECUTABLE_DEBUG) $(EXECUTABLE_RELEASE) $(OBJECTS)

