################################################################################
#
# NMAKE Makefile for PDCurses library - DOS MSC
#
# Usage: nmake -f [path\]dosmsc.mak [DEBUG=1] [target]
#
# where target can be any of:
# [all|demos|pdcurses.lib|panel.lib|testcurs.exe...]
#
################################################################################
#
# First, set the environment variable PDCURSES_SRCDIR, and/or edit the
# lines below; for example, "set PDCURSES_SRCDIR=c:\pdcurses".
#
################################################################################
PDCURSES_HOME	= $(PDCURSES_SRCDIR)
MODEL		= L       # one of L, S, M, T, H, C
SIZE		= LARGE    # one of LARGE, SMALL, MEDIUM, TINY, HUGE, COMPACT
################################################################################
# Nothing below here should require changing.
################################################################################

!include $(PDCURSES_HOME)\version

PDCURSES_CURSES_H	= $(PDCURSES_HOME)\curses.h
PDCURSES_CURSPRIV_H	= $(PDCURSES_HOME)\curspriv.h
PDCURSES_HEADERS	= $(PDCURSES_CURSES_H) $(PDCURSES_CURSPRIV_H)
PANEL_HEADER		= $(PDCURSES_HOME)\panel.h
TERM_HEADER		= $(PDCURSES_HOME)\term.h

srcdir		= $(PDCURSES_HOME)\pdcurses
osdir		= $(PDCURSES_HOME)\dos
pandir		= $(PDCURSES_HOME)\panel
demodir		= $(PDCURSES_HOME)\demos

PDCURSES_DOS_H	= $(osdir)\pdcdos.h

CC		= cl

!ifdef DEBUG
CFLAGS		= /nologo /Od /Zi /DPDCDEBUG
LDFLAGS		= /CO /NOE /SE:160 
!else
CFLAGS		= /Ox
LDFLAGS		= /NOE /SE:160
!endif

CPPFLAGS	= -I$(PDCURSES_HOME)

CCFLAGS		= /J /nologo /c /EM /D$(SIZE) /A$(MODEL) $(CFLAGS) $(CPPFLAGS)

LINK		= link

CCLIBS		=

LIBEXE		= lib

LIBCURSES	= pdcurses.lib
LIBPANEL	= panel.lib

LIBRARIES	= $(LIBCURSES) $(LIBPANEL)
DEMOS		= testcurs.exe newdemo.exe xmas.exe tuidemo.exe \
firework.exe ptest.exe rain.exe worm.exe

################################################################################
all:	$(LIBRARIES) $(DEMOS)

clean:
	-del *.obj
	-del *.lib
	-del *.exe

demos:	$(DEMOS)

#------------------------------------------------------------------------

LIBOBJS = addch.obj addchstr.obj addstr.obj attr.obj beep.obj bkgd.obj \
border.obj clear.obj color.obj delch.obj deleteln.obj getch.obj \
getstr.obj getyx.obj inch.obj inchstr.obj initscr.obj inopts.obj \
insch.obj insstr.obj instr.obj kernel.obj mouse.obj move.obj outopts.obj \
overlay.obj pad.obj printw.obj refresh.obj scanw.obj scr_dump.obj \
scroll.obj slk.obj termattr.obj terminfo.obj touch.obj util.obj \
window.obj

PDCOBJS = pdcclip.obj pdcdebug.obj pdcdisp.obj pdcgetsc.obj pdckbd.obj \
pdcscrn.obj pdcsetsc.obj pdcutil.obj pdcwin.obj

PANOBJS = panel.obj


pdcurses.lib : $(LIBOBJS) $(PDCOBJS)
	$(LIBEXE) $@ @$(osdir)\mscdos.lrf

panel.lib : $(PANOBJS)
	$(LIBEXE) $@ -+$(PANOBJS);

addch.obj: $(srcdir)\addch.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\addch.c

addchstr.obj: $(srcdir)\addchstr.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\addchstr.c

addstr.obj: $(srcdir)\addstr.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\addstr.c

attr.obj: $(srcdir)\attr.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\attr.c

beep.obj: $(srcdir)\beep.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\beep.c

bkgd.obj: $(srcdir)\bkgd.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\bkgd.c

border.obj: $(srcdir)\border.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\border.c

clear.obj: $(srcdir)\clear.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\clear.c

color.obj: $(srcdir)\color.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\color.c

delch.obj: $(srcdir)\delch.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\delch.c

deleteln.obj: $(srcdir)\deleteln.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\deleteln.c

getch.obj: $(srcdir)\getch.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\getch.c

getstr.obj: $(srcdir)\getstr.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\getstr.c

getyx.obj: $(srcdir)\getyx.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\getyx.c

inch.obj: $(srcdir)\inch.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\inch.c

inchstr.obj: $(srcdir)\inchstr.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\inchstr.c

initscr.obj: $(srcdir)\initscr.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\initscr.c

inopts.obj: $(srcdir)\inopts.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\inopts.c

insch.obj: $(srcdir)\insch.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\insch.c

insstr.obj: $(srcdir)\insstr.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\insstr.c

instr.obj: $(srcdir)\instr.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\instr.c

kernel.obj: $(srcdir)\kernel.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\kernel.c

mouse.obj: $(srcdir)\mouse.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\mouse.c

move.obj: $(srcdir)\move.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\move.c

outopts.obj: $(srcdir)\outopts.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\outopts.c

overlay.obj: $(srcdir)\overlay.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\overlay.c

pad.obj: $(srcdir)\pad.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\pad.c

printw.obj: $(srcdir)\printw.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\printw.c

refresh.obj: $(srcdir)\refresh.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\refresh.c

scanw.obj: $(srcdir)\scanw.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\scanw.c

scr_dump.obj: $(srcdir)\scr_dump.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\scr_dump.c

scroll.obj: $(srcdir)\scroll.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\scroll.c

slk.obj: $(srcdir)\slk.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\slk.c

termattr.obj: $(srcdir)\termattr.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\termattr.c

terminfo.obj: $(srcdir)\terminfo.c $(PDCURSES_HEADERS) $(TERM_HEADER)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\terminfo.c

touch.obj: $(srcdir)\touch.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\touch.c

util.obj: $(srcdir)\util.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\util.c

window.obj: $(srcdir)\window.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\window.c


pdcclip.obj: $(osdir)\pdcclip.c $(PDCURSES_HEADERS) $(PDCURSES_DOS_H)
	$(CC) $(CCFLAGS) -Fo$@ $(osdir)\pdcclip.c

pdcdebug.obj: $(srcdir)\pdcdebug.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\pdcdebug.c

pdcdisp.obj: $(osdir)\pdcdisp.c $(PDCURSES_HEADERS) $(PDCURSES_DOS_H)
	$(CC) $(CCFLAGS) -Fo$@ $(osdir)\pdcdisp.c

pdcgetsc.obj: $(osdir)\pdcgetsc.c $(PDCURSES_HEADERS) $(PDCURSES_DOS_H)
	$(CC) $(CCFLAGS) -Fo$@ $(osdir)\pdcgetsc.c

pdckbd.obj: $(osdir)\pdckbd.c $(PDCURSES_HEADERS) $(PDCURSES_DOS_H)
	$(CC) $(CCFLAGS) -Fo$@ $(osdir)\pdckbd.c

pdcscrn.obj: $(osdir)\pdcscrn.c $(PDCURSES_HEADERS) $(PDCURSES_DOS_H)
	$(CC) $(CCFLAGS) -Fo$@ $(osdir)\pdcscrn.c

pdcsetsc.obj: $(osdir)\pdcsetsc.c $(PDCURSES_HEADERS) $(PDCURSES_DOS_H)
	$(CC) $(CCFLAGS) -Fo$@ $(osdir)\pdcsetsc.c

pdcutil.obj: $(osdir)\pdcutil.c $(PDCURSES_HEADERS) $(PDCURSES_DOS_H)
	$(CC) $(CCFLAGS) -Fo$@ $(osdir)\pdcutil.c

pdcwin.obj: $(srcdir)\pdcwin.c $(PDCURSES_HEADERS)
	$(CC) $(CCFLAGS) -Fo$@ $(srcdir)\pdcwin.c

#------------------------------------------------------------------------

panel.obj: $(pandir)\panel.c $(PDCURSES_HEADERS) $(PANEL_HEADER)
	$(CC) $(CCFLAGS) -Fo$@ $(pandir)\panel.c

#------------------------------------------------------------------------

firework.exe: firework.obj $(LIBCURSES)
	$(LINK) $(LDFLAGS) $*.obj,$*,,$(LIBCURSES);

newdemo.exe: newdemo.obj $(LIBCURSES)
	$(LINK) $(LDFLAGS) $*.obj,$*,,$(LIBCURSES);

ptest.exe: ptest.obj $(LIBCURSES) $(LIBPANEL)
	$(LINK) $(LDFLAGS) $*.obj,$*,,$(LIBPANEL)+$(LIBCURSES);

rain.exe: rain.obj $(LIBCURSES)
	$(LINK) $(LDFLAGS) $*.obj,$*,,$(LIBCURSES);

testcurs.exe: testcurs.obj $(LIBCURSES)
	$(LINK) $(LDFLAGS) $*.obj,$*,,$(LIBCURSES);

tuidemo.exe: tuidemo.obj tui.obj $(LIBCURSES)
	$(LINK) $(LDFLAGS) $*.obj+tui.obj,$*,,$(LIBCURSES);

worm.exe: worm.obj $(LIBCURSES)
	$(LINK) $(LDFLAGS) $*.obj,$*,,$(LIBCURSES);

xmas.exe: xmas.obj $(LIBCURSES)
	$(LINK) $(LDFLAGS) $*.obj,$*,,$(LIBCURSES);


firework.obj: $(demodir)\firework.c $(PDCURSES_CURSES_H)
	$(CC) $(CCFLAGS) -Fo$@ $(demodir)\firework.c

newdemo.obj: $(demodir)\newdemo.c $(PDCURSES_CURSES_H)
	$(CC) $(CCFLAGS) -Fo$@ $(demodir)\newdemo.c

ptest.obj: $(demodir)\ptest.c $(PANEL_HEADER) $(PDCURSES_CURSES_H)
	$(CC) $(CCFLAGS) -Fo$@ $(demodir)\ptest.c

rain.obj: $(demodir)\rain.c $(PDCURSES_CURSES_H)
	$(CC) $(CCFLAGS) -Fo$@ $(demodir)\rain.c

testcurs.obj: $(demodir)\testcurs.c $(PDCURSES_CURSES_H)
	$(CC) $(CCFLAGS) -Fo$@ $(demodir)\testcurs.c

tui.obj: $(demodir)\tui.c $(demodir)\tui.h $(PDCURSES_CURSES_H)
	$(CC) $(CCFLAGS) -Fo$@ $(demodir)\tui.c

tuidemo.obj: $(demodir)\tuidemo.c $(PDCURSES_CURSES_H)
	$(CC) $(CCFLAGS) -Fo$@ $(demodir)\tuidemo.c

worm.obj: $(demodir)\worm.c $(PDCURSES_CURSES_H)
	$(CC) $(CCFLAGS) -Fo$@ $(demodir)\worm.c

xmas.obj: $(demodir)\xmas.c $(PDCURSES_CURSES_H)
	$(CC) $(CCFLAGS) -Fo$@ $(demodir)\xmas.c

dist: $(PDCLIBS)
	echo PDCurses $(VERDOT) for Microsoft C++ 6.0 > file_id.diz
	echo ------------------------------------------ >> file_id.diz
	echo Public Domain Curses library for >> file_id.diz
	echo Microsoft C/C++ 6.0 for DOS. >> file_id.diz
	echo Source available in PDCURS$(VER).ZIP >> file_id.diz
	echo Public Domain. >> file_id.diz
	echo $(PDCURSES_HOME)\README > flist
	echo $(PDCURSES_HOME)\HISTORY >> flist
	echo $(PDCURSES_HOME)\maintain.er >> flist
	echo $(PDCURSES_HOME)\curses.h >> flist
	echo $(PDCURSES_HOME)\curspriv.h >> flist
	echo $(PDCURSES_HOME)\panel.h >> flist
	echo $(PDCURSES_HOME)\term.h >> flist
	echo $(LIBCURSES) >> flist
	echo $(LIBPANEL) >> flist
	echo file_id.diz >> flist
	zip -9jX pdc$(VER)msc -@ <flist
	del flist
	del file_id.diz
