/*
 *
 *      Copyright (c) 1999 - 2006 Oracle. All rights reserved.
 *
 *      This material is the confidential property of Oracle Corporation or its
 *      licensors and may be used, reproduced, stored or transmitted only in
 *      accordance with a valid Oracle license or sublicense agreement.
 *
 */

#ifndef lint
static  char    Sccs_id[] = "@(#)%Portal Version: fm_bill_pol_valid_transfer.c:BillingVelocityInt:2:2006-Sep-05 21:55:44 %";
#endif

/*******************************************************************
 * Contains the PCM_OP_BILL_POL_VALID_TRANSFER operation. 
 *******************************************************************/

#include <stdio.h> 
#include <string.h> 
 
#include "pcm.h"
#include "ops/bill.h"
#include "pin_bill.h"
#include "pin_cust.h"
#include "cm_fm.h"
#include "pin_errs.h"
#include "pinlog.h"

#define FILE_SOURCE_ID  "fm_bill_pol_valid_transfer.c(1.7)"


/*******************************************************************
 * Routines contained within.
 *******************************************************************/
EXPORT_OP void
op_bill_pol_valid_transfer(
        cm_nap_connection_t	*connp,
	u_int			opcode,
        u_int			flags,
        pin_flist_t		*i_flistp,
        pin_flist_t		**o_flistpp,
        pin_errbuf_t		*ebufp);

/*******************************************************************
 * Routines needed from elsewhere.
 *******************************************************************/
extern void fm_bill_pol_validate_item_fields();

/*******************************************************************
 * Main routine for the PCM_OP_BILL_POL_VALID_TRANSFER operation.
 *******************************************************************/
void
op_bill_pol_valid_transfer(
        cm_nap_connection_t	*connp,
	u_int			opcode,
        u_int			flags,
        pin_flist_t		*i_flistp,
        pin_flist_t		**o_flistpp,
        pin_errbuf_t		*ebufp)
{
	pcm_context_t		*ctxp = connp->dm_ctx;
	pin_flist_t		*r_flistp = NULL;
	pin_cookie_t		cookie = NULL;
	int32			element_id = 0;
	pin_flist_t		*flistp;
	char			*descrp = NULL;
	void			*vp = NULL;

	u_int			result = 0;

	if (PIN_ERR_IS_ERR(ebufp))
		return;
	PIN_ERR_CLEAR_ERR(ebufp);

	/***********************************************************
	 * Insanity check.
	 ***********************************************************/
	if (opcode != PCM_OP_BILL_POL_VALID_TRANSFER) {
		pin_set_err(ebufp, PIN_ERRLOC_FM,
			PIN_ERRCLASS_SYSTEM_DETERMINATE,
			PIN_ERR_BAD_OPCODE, 0, 0, opcode);
		PIN_ERR_LOG_EBUF(PIN_ERR_LEVEL_ERROR,
			"op_bill_pol_valid_transfer opcode error", ebufp);
		return;
	}

	/***********************************************************
	 * Debug: What we got.
	 ***********************************************************/
	PIN_ERR_LOG_FLIST(PIN_ERR_LEVEL_DEBUG,
		"op_bill_pol_valid_transfer input flist", i_flistp);

	/************************************************************
	* Iterate the item list
	************************************************************/
	while( ( flistp = PIN_FLIST_ELEM_GET_NEXT(i_flistp,
			PIN_FLD_ITEMS, &element_id, 
				1, &cookie, ebufp)) != NULL) {

		/***************************************************
		 * Validate the item fields.
		 ***************************************************/
		fm_bill_pol_validate_item_fields(connp, 
				flistp, &result, ebufp);
	}

	/***********************************************************
	 * Construct the return flist.
	 ***********************************************************/
	r_flistp = PIN_FLIST_CREATE(ebufp);

	vp = PIN_FLIST_FLD_GET(i_flistp, PIN_FLD_ITEM_OBJ, 0, ebufp);
	PIN_FLIST_FLD_SET(r_flistp, PIN_FLD_POID, vp, ebufp);

	/***********************************************************
	 * Set the validation result field (pass or fail).
	 ***********************************************************/
	result |= PIN_BOOLEAN_TRUE;
	PIN_FLIST_FLD_SET(r_flistp, PIN_FLD_RESULT, (void *)&result, ebufp);

	/***********************************************************
	 * Set the Description about the validation.
	 ***********************************************************/
	descrp = (char *)"Succeeded";
	PIN_FLIST_FLD_SET(r_flistp, PIN_FLD_DESCR, (void *)descrp, ebufp);

	/***********************************************************
	 * Results.
	 ***********************************************************/
	if (PIN_ERR_IS_ERR(ebufp)) {

		/***************************************************
		 * Log something and return nothing.
		 ***************************************************/
		PIN_ERR_LOG_EBUF(PIN_ERR_LEVEL_ERROR,
			"op_bill_pol_valid_transfer error", ebufp);
		PIN_FLIST_DESTROY(r_flistp, NULL);
		*o_flistpp = NULL;

	} else {

		/***************************************************
		 * Point the real return flist to the right thing.
		 ***************************************************/
		PIN_ERR_CLEAR_ERR(ebufp);
		*o_flistpp = r_flistp;

		/***************************************************
		 * Debug: What we're sending back.
		 ***************************************************/
		PIN_ERR_LOG_FLIST(PIN_ERR_LEVEL_DEBUG,
			"op_bill_pol_valid_transfer return flist", r_flistp);

	}

	return;
}
