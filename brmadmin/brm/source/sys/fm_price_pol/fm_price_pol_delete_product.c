/* continuus file information --- %full_filespec: fm_price_pol_delete_product.c~5:csrc:1 % */
/*******************************************************************
 *
 *  @(#) %full_filespec: fm_price_pol_delete_product.c~5:csrc:1 %
 *
 *      Copyright (c) 1999 - 2006  Oracle. All rights reserved.
 *
 *      This material is the confidential property of Oracle Corporation
 *      or its subsidiaries or licensors and may be used, reproduced, stored
 *      or transmitted only in accordance with a valid Oracle license or
 *      sublicense agreement.
 *
 *******************************************************************/

/******************************************************************
 ******************************************************************
 **
 ** This policy opcode can be used to perform validations over and
 ** above those which will be performed by fm_price
 **
 ** By default it just passes 
 **
 ******************************************************************
 ******************************************************************/

#ifndef lint
static  char    Sccs_id[] = "@(#)%Portal Version: fm_price_pol_delete_product.c:ServerIDCVelocityInt:1:2006-Sep-06 16:46:54 %";
#endif

/************************************************************************
 * This policy determines whether or not the requested product
 * object may be safely deleted from the database or not.
 ************************************************************************/

#include <stdio.h>
#include <stdlib.h>

#include "pcm.h"
#include "ops/price.h"
#include "cm_fm.h"
#include "pin_errs.h"
#include "pinlog.h"
#include "pin_price.h"

#define FILE_SOURCE_ID  "fm_price_pol_delete_product.c (1.9)"
 
EXPORT_OP void
op_price_pol_delete_product(
        cm_nap_connection_t	*connp,
	u_int32			opcode,
        u_int32			flags,
        pin_flist_t		*i_flistp,
        pin_flist_t		**r_flistpp,
        pin_errbuf_t		*ebufp);

/*******************************************************************
 * Main routine for the PCM_OP_PRICE_POL_DELETE_PRODUCT operation.
 *******************************************************************/
EXPORT_OP void
op_price_pol_delete_product(
        cm_nap_connection_t	*connp,
	u_int32			opcode,
        u_int32			flags,
        pin_flist_t		*i_flistp,
        pin_flist_t		**r_flistpp,
        pin_errbuf_t		*ebufp)
{
	pcm_context_t		*ctxp = connp->dm_ctx;
	void			*vp = NULL;
	u_int32			result = 0;

	if (PIN_ERR_IS_ERR(ebufp))
		return;
	PIN_ERR_CLEAR_ERR(ebufp);

	/***********************************************************
	 * Null out results until we have some.
	 ***********************************************************/
	*r_flistpp = PIN_FLIST_CREATE( ebufp );

	/***********************************************************
	 * Insanity check.
	 ***********************************************************/
	if (opcode != PCM_OP_PRICE_POL_DELETE_PRODUCT) {
		pin_set_err(ebufp, PIN_ERRLOC_FM,
			PIN_ERRCLASS_SYSTEM_DETERMINATE,
			PIN_ERR_BAD_OPCODE, 0, 0, opcode);
		PIN_ERR_LOG_EBUF(PIN_ERR_LEVEL_ERROR,
			"bad opcode in op_price_pol_delete_product", ebufp);
		return;
	}

	/***********************************************************
	 * Debug - What we got.
	 ***********************************************************/
	PIN_ERR_LOG_FLIST(PIN_ERR_LEVEL_DEBUG,
		"op_price_pol_delete_product input flist", i_flistp);

	vp = PIN_FLIST_FLD_GET(i_flistp, PIN_FLD_POID, 0, ebufp);
	PIN_FLIST_FLD_SET(*r_flistpp, PIN_FLD_POID, vp, ebufp);

	result = PIN_PRICE_VERIFY_PASSED;
	PIN_FLIST_FLD_SET(*r_flistpp, PIN_FLD_RESULT, (void *)&result, ebufp);


	/***********************************************************
	 * Error?
	 ***********************************************************/
	if (PIN_ERR_IS_ERR(ebufp)) {
		PIN_ERR_LOG_EBUF(PIN_ERR_LEVEL_DEBUG,
			"op_price_pol_delete_product error", ebufp);
	} else {
		PIN_ERR_LOG_FLIST(PIN_ERR_LEVEL_DEBUG,
			"op_price_pol_delete_product return flist", *r_flistpp);
	}

	return;
}

