# Makefile for iPhone Application for Xcode gcc compiler (SDK Headers)

PROJECTNAME=Unicom
APPFOLDER=$(PROJECTNAME).app
INSTALLFOLDER=$(PROJECTNAME).app

IPHONE_IP=192.168.1.76

CC=arm-apple-darwin9-gcc
LD=$(CC)

LDFLAGS=	-lobjc \
		-bind_at_load \
		-framework Foundation \
		-framework CoreFoundation \
		-framework UIKit \
		-w

CFLAGS = -DDEBUG -std=c99
CFLAGS += -Diphoneos_version_min=3.1

BUILDDIR=./build
SRCDIR=./Classes
RESDIR=./Resources
OBJS=$(patsubst %.m,%.o,$(wildcard $(SRCDIR)/SQLPO/*.m))
OBJS+=$(patsubst %.m,%.o,$(wildcard $(SRCDIR)/ObjectiveResource/*.m))
OBJS+=$(patsubst %.m,%.o,$(wildcard $(SRCDIR)/**/*.m))
OBJS+=$(patsubst %.c,%.o,$(wildcard $(SRCDIR)/**/*.c))
OBJS+=$(patsubst %.m,%.o,$(wildcard *.m))
PCH=$(wildcard *.pch)
RESOURCES=$(wildcard $(RESDIR)/*)

all:	$(PROJECTNAME) bundle

$(PROJECTNAME):	$(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^ 

bundle:	$(PROJECTNAME)
	@mkdir -p $(BUILDDIR)/$(APPFOLDER)
	@cp $(PROJECTNAME) $(PROJECT).app/$(PROJECTNAME)_
	@cp -r $(RESOURCES) $(BUILDDIR)/$(APPFOLDER)
	@cp Info.plist $(BUILDDIR)/$(APPFOLDER)
	@echo "APPL????" > $(BUILDDIR)/$(APPFOLDER)/PkgInfo
	@mv $(PROJECTNAME) $(BUILDDIR)/$(APPFOLDER)

%.o:	%.m
	$(CC) -c $(CFLAGS) $< -o $@

deploy: clean bundle
	scp -r $(BUILDDIR)/$(APPFOLDER) root@$(IPHONE_IP):/Applications/$(INSTALLFOLDER)
	@ssh root@$(IPHONE_IP) "cd /Applications/$(INSTALLFOLDER) ; ldid -S $(PROJECTNAME)_; killall SpringBoard"

uninstall:
	ssh root@$(IPHONE_IP) 'rm -fr /Applications/$(INSTALLFOLDER); respring'
	@echo "Application $(INSTALLFOLDER) uninstalled, please respring iPhone"

clean:
	@rm -f $(SRCDIR)/**/*.o *.o
	@rm -rf $(BUILDDIR)
	@rm -f $(PROJECTNAME)
