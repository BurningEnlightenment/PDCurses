/*
 * Copyright (C) 1998-2001  Mark Hessling <M.Hessling@qut.edu.au>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the Free
 * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#ifndef _RXPACK_H
#define _RXPACK_H

#ifdef HAVE_CONFIG_H
# include "config.h"
#else
# include "defines.h"
#endif

#include <stdio.h>

#ifdef HAVE_CTYPE_H
# include <ctype.h>
#endif

#ifdef HAVE_STDLIB_H
# include <stdlib.h>
#endif

#ifdef HAVE_STRING_H
# include <string.h>
#endif

#ifdef HAVE_ERRNO_H
# include <errno.h>
#endif

#ifdef HAVE_ASSERT_H
# include <assert.h>
#endif

#ifdef HAVE_SYS_TYPES_H
# include <sys/types.h>
#endif

#ifdef HAVE_SYS_STAT_H
# include <sys/stat.h>
#endif

#ifdef HAVE_DIRENT_H
# include <dirent.h>
#endif

#ifdef HAVE_MALLOC_H
# include <malloc.h>
#endif

#ifdef HAVE_STDARG_H
# include <stdarg.h>
#endif

#ifdef HAVE_UNISTD_H
# include <unistd.h>
#endif

#ifdef HAVE_GETOPT_H
# include <getopt.h>
#endif

#ifdef HAVE_IO_H
# include <io.h>
#endif

/*
 * All things that this application may require out of os2.h must be
 * specified here in one place.  This is because EMX includes all Rexx
 * related stuff in os2.h, not in a serperate header file.  This makes
 * it difficult to use another Rexx interpreter with EMX :-(
 */
#if defined(OS2) || defined(__OS2__)
# if !defined(EMXVIDEO)
#  define INCL_VIO
#  define INCL_KBD
# endif
# if defined(USE_OS2REXX)
#  define INCL_RXSHV      /* Shared variable support */
#  define INCL_RXFUNC     /* External functions support */
#  define INCL_RXSYSEXIT  /* System exit routines */
#  define INCL_RXSUBCOM   /* Subcommand routines */
#  include <os2.h>
# else
#  include <os2.h>
#  define INCL_RXSHV      /* Shared variable support */
#  define INCL_RXFUNC     /* External functions support */
#  define INCL_RXSYSEXIT  /* System exit routines */
#  define INCL_RXSUBCOM   /* Subcommand routines */
# endif
#else
# define INCL_RXSHV      /* Shared variable support */
# define INCL_RXFUNC     /* External functions support */
# define INCL_RXSYSEXIT  /* System exit routines */
# define INCL_RXSUBCOM   /* Subcommand routines */
#endif

/*
 * The following header file is supplied by the application package.
 * It specifies any application-specific header files and #defines
 * the following:
 * RXPACKAGE_MAGIC_NUMBER  12345     - any number
 * RXPACKAGE_DEBUG_VAR     "ENV_VAR" - an env variable enclosed in quotes
 */
#include "apphead.h"

#include "rxdef.h"

#define RETBUFLEN 250

#if defined(DYNAMIC)
# define DYNAMIC_LIBRARY 1
#endif

#ifndef TRUE
# define TRUE   1
# define FALSE  0
#endif

/* 
 * Run time modes 
 */
#define MODE_DEBUG        1
#define MODE_VERBOSE      2
#define MODE_INTERNAL     4
#define MODE_HALTONERROR  8

#define REXX_FAIL      1

#define RXSTRCAT(dst,dstlen,src,srclen) (memcpy((dst)+(dstlen),(src),(srclen)),(dstlen)+=(srclen),*((dst)+(dstlen))='\0')
#define RXSTRCPY(dst,dstlen,src,srclen) (memcpy((dst),(src),(srclen)),(dstlen)=(srclen),*((dst)+(dstlen))='\0')

#if !defined(max)
# define max(a,b)        (((a) > (b)) ? (a) : (b))
#endif

#if !defined(min)
# define min(a,b)        (((a) < (b)) ? (a) : (b))
#endif

#if !defined(MAX_PATH)
# if defined(NAME_MAX)
#  define MAX_PATH NAME_MAX
# elif defined(MAXNAMLEN)
#  define MAX_PATH MAXNAMLEN
# else
#  define MAX_PATH 255
# endif
#endif

#ifdef USE_REXX6000
typedef USHORT RexxFunctionHandler(PSZ, ULONG, PRXSTRING, PSZ, PRXSTRING) ;
#endif

/*-----------------------------------------------------------------------------
 * Definition of an external function
 *----------------------------------------------------------------------------*/
typedef struct {
   RRFD_ARG0_TYPE      ExternalName;
   RRFE_ARG1_TYPE      EntryPoint; 
   RRFD_ARG2_TYPE      InternalName;
   int                 DllLoad;
} RexxFunction;

/*
 * The following structure contains all "global" data common to all
 * external function packages.  A similar structure should exists
 * for package-specific data.
 */
typedef struct 
{
   int RxRunFlags;                    /* debug/verbose flags */
   char FName[100];                   /* current function name */
   FILE *RxTraceFilePointer;          /* file pointer for all output */
   char RxTraceFileName[MAX_PATH];    /* filename of output file */
   int deallocate;                    /* indicates if rxpack should deallocate this structure */
   int terminated;                    /* indicates if rxpack has called RxTermPackage() for this structure */
} RxPackageGlobalDataDef;

typedef int PackageInitialiser( RxPackageGlobalDataDef * );
typedef int PackageTerminator( RxPackageGlobalDataDef * );

#ifdef HAVE_PROTO
# define Args(a) a
#else
# define Args(a) ()
#endif

RxPackageGlobalDataDef *FunctionPrologue Args(( RxPackageGlobalDataDef *, PackageInitialiser *, char *, ULONG, RXSTRING * ));
void FunctionTrace Args(( RxPackageGlobalDataDef *, char *, ... ));
long FunctionEpilogue Args(( RxPackageGlobalDataDef *, char *, long ));
void InternalTrace Args(( RxPackageGlobalDataDef *, char *, ... ));
void RxDisplayError Args(( RxPackageGlobalDataDef *, RFH_ARG0_TYPE, ... ));
RxPackageGlobalDataDef *InitRxPackage Args(( RxPackageGlobalDataDef *, PackageInitialiser *, int * ));
int TermRxPackage Args(( RxPackageGlobalDataDef *, PackageTerminator *, RexxFunction *, char *, int ));
int RegisterRxFunctions Args(( RxPackageGlobalDataDef *, RexxFunction *, char * ));
int RegisterRxSubcom Args(( RxPackageGlobalDataDef *, RexxSubcomHandler ));
int QueryRxFunction Args(( RxPackageGlobalDataDef *, char * ));
int DeregisterRxFunctions Args(( RxPackageGlobalDataDef *, RexxFunction *, int ));
char *make_upper Args(( char * ));
char *AllocString Args(( char *, int ));
char *MkAsciz Args(( char *, int, char *, int ));
int SetRexxVariable Args(( RxPackageGlobalDataDef *,char *, int, char *, int ));
RXSTRING *GetRexxVariable Args(( RxPackageGlobalDataDef *, char *, RXSTRING *, int ));
int *GetRexxVariableInteger Args(( RxPackageGlobalDataDef *, char *name, int *value, int suffix ));
int StrToInt Args(( RXSTRING *, ULONG * ));
int StrToNumber Args(( RXSTRING *, LONG * ));
int StrToBool Args(( RXSTRING *, ULONG * ));
int RxSetTraceFile Args(( RxPackageGlobalDataDef *, char * ));
char *RxGetTraceFile Args(( RxPackageGlobalDataDef * ));
void RxSetRunFlags Args(( RxPackageGlobalDataDef *, int ));
int RxGetRunFlags Args(( RxPackageGlobalDataDef * ));
int RxReturn Args(( RxPackageGlobalDataDef *, RXSTRING * ));
int RxReturnString Args(( RxPackageGlobalDataDef *, RXSTRING *, char * ));
int RxReturnStringAndFree Args(( RxPackageGlobalDataDef *, RXSTRING *, char *, int ));
int RxReturnNumber Args(( RxPackageGlobalDataDef *, RXSTRING *, long ));
int RxReturnDouble Args(( RxPackageGlobalDataDef *, RXSTRING *, double ));
int RxReturnPointer Args(( RxPackageGlobalDataDef *, RXSTRING *, void * ));
int memcmpi Args(( char *, char *, int ));
int my_checkparam Args(( RxPackageGlobalDataDef *, const char *, int, int, int ));

#ifdef DEBUG
# define DEBUGDUMP(x) {x;}
#else
# define DEBUGDUMP(x) {}
#endif

#endif /* !_RXPACK_H */