##########################################################################
#
# Copyright (c) 1999, 2009, Oracle and/or its affiliates. All rights reserved. 
# 
#	This material is the confidential property of Oracle Corporation 
# 	or its licensors and may be used, reproduced, stored or transmitted 
# 	only in accordance with a valid Oracle license or sublicense agreement.
#
##########################################################################
#
#   File:  locale_descr.es
#
#   Description:
#
#	This file contains localized string object definitions.
#
#	Locale:  es ( Spanish )
#
#	Domain:  Locale Descriptions - es
#
#   Rules:
#
#	[1] Uniqueness:
#
#	    The combination of locale, domain, string ID, and string
#	    version must uniquely define a string object within the
#	    universe of all string objects.
#
#	[2] Locale
#
#	    Only one locale may be specified in this file.  The locale
#	    definition must be the first non-comment statement.
#
#	[3] Domain
#
#	    There may be multiple domains specified in this file.  The
#	    domain will apply to all string definitions that follow
#	    until the next domain definition statement appears.
#
#	[4] String Format:
#
#	    Within this file all strings must be delimited by an opening
#	    and closing double-quote character.  The quotes will not be
#	    part of the string stored in the database.  A double-quote
#	    character can be an element of the string if it is escaped
#	    with a backslash, for example "Delete \"unneeded\" files."
#	    will be stored as "Delete "unneeded" files.".
#
#	    Substitution parameters can be specified with %i, where i is
#	    an integer from 0 to 99.  The percent character can be an
#	    element of the string if it is escaped with a backslash, for
#	    example "It is 100\% good.".  Here is an example of an error
#	    string that specifies one substitution parameter:
#
#				File %0 not found.
#
#	    If the substitution string is "pin.conf" the formatted
#	    string will be "File pin.conf not found.".
#
#           The STRING and optional HELPSTR are localizable.  This file must be
#           in UTF-8 encoding. The LOCALE and DOMAIN strings are assumed
#           to be ASCII (no extended-ASCII characters nor multiple byte
#           characters are allowed).
#
#	[5] String ID:
#
#	    A string ID must be unique within a domain.
#
#	[6] String Version:
#
#	    Each string has an individual version, typically starting
#	    from 1, that the string owner assigns.
#
##########################################################################

LOCALE = "es" ;

DOMAIN = "Locale Descriptions - es" ;
STR
	ID = 1 ;
	VERSION = 1 ;
	STRING = "Danés (Dinamarca)" ;
	HELPSTR = "da" ;
END
STR
	ID = 2 ;
	VERSION = 1 ;
	STRING = "Alemán (Alemania)" ;
	HELPSTR = "de" ;
END
STR
	ID = 3 ;
	VERSION = 1 ;
	STRING =  "Alemán (Austria)" ;
	HELPSTR = "de_AT" ;
END
STR
	ID = 4 ;
	VERSION = 1 ;
	STRING = "Alemán (Suiza)" ;
	HELPSTR = "de_CH" ;
END
STR
	ID = 5 ;
	VERSION = 1 ;
	STRING = "Inglés (EE.UU.)" ;
	HELPSTR = "en_US" ;
END
STR
	ID = 6 ;
	VERSION = 1 ;
	STRING = "Inglés (Australia)" ;
	HELPSTR = "en_AU" ;
END
STR
	ID = 7 ;
	VERSION = 1 ;
	STRING = "Inglés (Canadá)" ;
	HELPSTR = "en_CA" ;
END
STR
	ID = 8 ;
	VERSION = 1 ;
	STRING = "Inglés (Nueva Zelanda)" ;
	HELPSTR = "en_NZ" ;
END
STR
	ID = 9 ;
	VERSION = 1 ;
	STRING = "Inglés (Reino Unido)" ;
	HELPSTR = "en_UK" ;
END
STR
	ID = 10 ;
	VERSION = 1 ;
	STRING = "Español (España)" ;
	HELPSTR = "es" ;
END
STR
	ID = 11 ;
	VERSION = 1 ;
	STRING = "Español (México)" ;
	HELPSTR = "es_MX" ;
END
STR
	ID = 12 ;
	VERSION = 1 ;
	STRING = "Francés (Francia)" ;
	HELPSTR = "fr" ;
END
STR
	ID = 13 ;
	VERSION = 1 ;
	STRING = "Francés (Bélgica)" ;
	HELPSTR = "fr_BE" ;
END
STR
	ID = 14 ;
	VERSION = 1 ;
	STRING = "Francés (Canadá)" ;
	HELPSTR = "fr_CA" ;
END
STR
	ID = 15 ;
	VERSION = 1 ;
	STRING = "Francés (Suiza)" ;
	HELPSTR = "fr_CH" ;
END
STR
	ID = 16 ;
	VERSION = 1 ;
	STRING = "Italiano (Italia)" ;
	HELPSTR = "it" ;
END
STR
	ID = 17 ;
	VERSION = 1 ;
	STRING = "Japonés (Japón)" ;
	HELPSTR = "ja" ;
END
STR
	ID = 18 ;
	VERSION = 1 ;
	STRING = "Coreano (Corea)" ;
	HELPSTR = "ko" ;
END

STR
	ID = 19 ;
	VERSION = 1 ;
	STRING = "Neerlandés (Países Bajos)" ;
	HELPSTR = "nl";
END
STR
	ID = 20 ;
	VERSION = 1 ;
	STRING = "Neerlandés (Bélgica)" ;
	HELPSTR = "nl_BE" ;
END
STR
	ID = 21 ;
	VERSION = 1 ;
	STRING = "Portugués (Portugal)" ;
	HELPSTR = "pt" ;
END
STR
	ID = 22 ;
	VERSION = 1 ;
	STRING = "Sueco (Suecia)" ;
	HELPSTR = "sve" ;
END

STR
	ID = 23 ;
	VERSION = 1 ;
	STRING = "Chino (República Popular de China)" ;
	HELPSTR = "zh" ;
END
STR
	ID = 24 ;
	VERSION = 1 ;
	STRING = "Chino (Taiwán)" ;
	HELPSTR = "zh_TW" ;
END
STR
	ID = 25 ;
	VERSION = 1 ;
	STRING = "Portugués (Brasil)" ;
	HELPSTR = "pt_BR" ;
END
STR
	ID = 26 ;
	VERSION = 1 ;
	STRING = "Noruego (Bokmal)" ;
	HELPSTR = "no" ;
END
STR
	ID = 27 ;
	VERSION = 1 ;
	STRING = "Noruego (Nynorsk)" ;
	HELPSTR = "no_NY" ;
END
STR
	ID = 28 ;
	VERSION = 1 ;
	STRING = "Checo" ;
	HELPSTR = "cz" ;
END
STR
	ID = 29 ;
	VERSION = 1 ;
	STRING = "Húngaro" ;
	HELPSTR = "hu" ;
END
STR
	ID = 30 ;
	VERSION = 1 ;
	STRING = "Ruso" ;
	HELPSTR = "ru" ;
END
STR
	ID = 31 ;
	VERSION = 1 ;
	STRING = "Polaco" ;
	HELPSTR = "pl" ;
END
STR
	ID = 32 ;
	VERSION = 1 ;
	STRING = "Finés" ;
	HELPSTR = "fi" ;
END
STR
	ID = 33 ;
	VERSION = 1 ;
	STRING = "Griego" ;
	HELPSTR = "el" ;
END
STR
	ID = 34 ;
	VERSION = 1 ;
	STRING = "Hebreo (Israel)" ;
	HELPSTR = "iw_IL" ;
END
STR
	ID = 35 ;
	VERSION = 1 ;
	STRING = "Búlgaro (Bulgaria)" ;
	HELPSTR = "bg_BG" ;
END
STR
	ID = 36 ;
	VERSION = 1 ;
	STRING = "Inglés (Irlanda)" ;
	HELPSTR = "en_IE" ;
END
