/*	
 *	@(#)%Portal Version: price.h:CommonIncludeInt:9:2008-Sep-17 00:23:23 %
 *	
 * Copyright (c) 1996, 2009, Oracle and/or its affiliates. 
 * All rights reserved. 
 *	
 *	This material is the confidential property of Oracle Corporation or its
 *	licensors and may be used, reproduced, stored or transmitted only in
 *	accordance with a valid Oracle license or sublicense agreement.
 */

#ifndef _PCM_PRICE_OPS_H_
#define _PCM_PRICE_OPS_H_

/*
 * This file contains the opcode definitions for the Price PCM API.
 */

/* 
   NAME: TOTAL RANGE; USED RANGE; RESERVED RANGE; ASSOCIATED FM (if any)
   =====================================================================
   PCM_PRICE_OPS:     631..674; 652..674; 631..651; fm_price
   PCM_PRICE_POL_OPS: 600..630, 675..699; ; 600..630; fm_price_pol
 */

#include "ops/base.h"

	/* opcodes for pricelist FM */
#define PCM_OP_PRICE_SET_PIPELINE_DISCOUNTMODEL	652
#define PCM_OP_PRICE_GET_DISCOUNT_INFO        	653
#define PCM_OP_PRICE_NOTIFY_PRICE_CHANGE        654
#define PCM_OP_PRICE_PREP_TAILORMADE_PRODUCT	655
#define PCM_OP_PRICE_SET_PIPELINE_RATEPLAN_INFO	656
#define PCM_OP_PRICE_GET_PRODUCT_INFO		657
#define PCM_OP_PRICE_GET_PIPELINE_RATEPLAN_INFO	658

#define PCM_OP_PRICE_COMMIT_PLAN		659
#define PCM_OP_PRICE_COMMIT_DEAL		660
#define PCM_OP_PRICE_COMMIT_PRODUCT		661
#define PCM_OP_PRICE_GET_PRICE_LIST		662
#define PCM_OP_PRICE_SET_PRICE_LIST		663
#define PCM_OP_PRICE_COMMIT_PLAN_LIST		666
#define PCM_OP_PRICE_SET_CAAR_MATRIX		667	/* Obsolete */
#define PCM_OP_PRICE_GET_CAAR_MATRIX		668	/* Obsolete */
#define PCM_OP_PRICE_DELETE_CAAR_MATRIX		669	/* Obsolete */
#define PCM_OP_PRICE_COMMIT_DISCOUNT		670
#define PCM_OP_PRICE_COMMIT_SPONSORSHIP		671
#define PCM_OP_PRICE_COMMIT_DEPENDENCY		672
#define PCM_OP_PRICE_COMMIT_TRANSITION		673
#define PCM_OP_PRICE_COMMIT_BEST_PRICING	674

	/* opcodes for pricelist policy FM */
#define PCM_OP_PRICE_POL_DELETE_DEAL		675
#define PCM_OP_PRICE_POL_DELETE_PRODUCT		676
#define PCM_OP_PRICE_POL_DELETE_RATE		677
#define PCM_OP_PRICE_POL_PREP_DEAL		678
#define PCM_OP_PRICE_POL_PREP_PRODUCT		679
#define PCM_OP_PRICE_POL_PREP_RATE		680
#define PCM_OP_PRICE_POL_VALID_DEAL		681
#define PCM_OP_PRICE_POL_VALID_PRODUCT		682
#define PCM_OP_PRICE_POL_VALID_RATE		683
#define PCM_OP_PRICE_POL_SET_CAAR_MATRIX	684	/* Obsolete */
#define PCM_OP_PRICE_POL_GET_CAAR_MATRIX	685	/* Obsolete */
#define PCM_OP_PRICE_POL_DELETE_DISCOUNT	686
#define PCM_OP_PRICE_POL_DELETE_SPONSORSHIP	687
#define PCM_OP_PRICE_POL_PREP_DISCOUNT		688
#define PCM_OP_PRICE_POL_PREP_SPONSORSHIP	689
#define PCM_OP_PRICE_POL_VALID_DISCOUNT		690
#define PCM_OP_PRICE_POL_VALID_SPONSORSHIP	691
#define PCM_OP_PRICE_POL_DELETE_DEPENDENCY	692
#define PCM_OP_PRICE_POL_PREP_DEPENDENCY	693
#define PCM_OP_PRICE_POL_VALID_DEPENDENCY	694
#define PCM_OP_PRICE_POL_DELETE_TRANSITION	695
#define PCM_OP_PRICE_POL_PREP_TRANSITION	696
#define PCM_OP_PRICE_POL_VALID_TRANSITION	697
#define PCM_OP_PRICE_POL_PREP_PIPELINE_DISCOUNTMODEL 698
#define PCM_OP_PRICE_POL_VALID_PIPELINE_DISCOUNTMODEL 699

#endif /* PCM_PRICE_OPS_H_ */
