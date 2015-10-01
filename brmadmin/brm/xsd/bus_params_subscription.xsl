<?xml version="1.0" encoding="UTF-8"?>
 <!--
  **************************************************************************
* Copyright (c) 2005, 2011, Oracle and/or its affiliates. All rights reserved. 
  * This material is the confidential property of Oracle Corporation or its*
  * licensors and may be used, reproduced, stored or transmitted only in   *
  * accordance with a valid Oracle license or sublicense agreement.        *
  **************************************************************************
 -->
<xsl:stylesheet
    version="1.0"
    xmlns="http://www.portal.com/schemas/BusinessConfig"
    xmlns:bc="http://www.portal.com/schemas/BusinessConfig"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="bc">

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <BusinessConfiguration
        xmlns="http://www.portal.com/schemas/BusinessConfig"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.portal.com/schemas/BusinessConfig business_configuration.xsd">
      <BusParamConfiguration>
        <BusParamConfigurationList>
          <ParamClass desc="Business logic parameters for Subscription" name="subscription">
            <xsl:apply-templates select="/bc:BusinessConfiguration/bc:BusParamConfigurationClass/bc:BusParamsSubscription/bc:*"/>
          </ParamClass>
        </BusParamConfigurationList>
      </BusParamConfiguration>
    </BusinessConfiguration>
  </xsl:template>

  <xsl:template match="bc:DiscountBasedOnContractDaysFeature">
    <xsl:element name="Param">
      <xsl:element name="Name">
        <xsl:text>discount_based_on_contract_days_feature</xsl:text>
      </xsl:element>
      <xsl:element name="Desc">
        Parameter to enable contract days counter feature. This needs to be set to 1 if the accounts contain the resource contract days counter.
      </xsl:element>
      <xsl:element name="Type">INT</xsl:element>
      <xsl:element name="Value">
        <xsl:choose>
          <xsl:when test="normalize-space(text()) = &apos;enabled&apos;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>0</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="bc:BestPricing">
    <xsl:element name="Param">
      <xsl:element name="Name">
        <xsl:text>best_pricing</xsl:text>
      </xsl:element>
      <xsl:element name="Desc">
        Parameter to enable or disable best pricing feature. 1 means enabled.
      </xsl:element>
      <xsl:element name="Type">INT</xsl:element>
      <xsl:element name="Value">
        <xsl:choose>
          <xsl:when test="normalize-space(text()) = &apos;enabled&apos;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>0</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="bc:RolloverTransfer">
    <xsl:element name="Param">
      <xsl:element name="Name">
        <xsl:text>rollover_transfer</xsl:text>
      </xsl:element>
      <xsl:element name="Desc">
        Parameter to enable or disable rollover transfer feature. 1 means enabled.
      </xsl:element>
      <xsl:element name="Type">INT</xsl:element>
      <xsl:element name="Value">
        <xsl:choose>
          <xsl:when test="normalize-space(text()) = &apos;enabled&apos;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>0</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </xsl:element>
  </xsl:template>

   <xsl:template match="bc:AutomatedMonitorSetup">
    <xsl:element name="Param">
      <xsl:element name="Name">
        <xsl:text>automated_monitor_setup</xsl:text>
      </xsl:element>
      <xsl:element name="Desc">
        Parameter to enable or disable automated monitor setup. Affects processing logic.
      </xsl:element>
      <xsl:element name="Type">INT</xsl:element>
      <xsl:element name="Value">
        <xsl:choose>
          <xsl:when test="normalize-space(text()) = &apos;enabled&apos;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>0</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="bc:BillTimeDiscountWhen">
    <xsl:element name="Param">
      <xsl:element name="Name">
        <xsl:text>bill_time_discount_when</xsl:text>
      </xsl:element>
      <xsl:element name="Desc">
        Parameter to indicate time to apply discount during billing. This discount could be applied either at each accounting cycle time or at the billing cycle time (i.e in the last accounting cycle in the case of multi-month billing cycle). The posible values are 0 (apply discount at each accounting cycle) and 1 (apply discount at billing cycle time). Default is 0.
      </xsl:element>
      <xsl:element name="Type">INT</xsl:element>
      <xsl:element name="Value">
        <xsl:choose>
          <xsl:when test="normalize-space(text()) = &apos;enabled&apos;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>0</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </xsl:element>
  </xsl:template>

 <xsl:template match="bc:ProductLevelValidation">
    <xsl:element name="Param">
      <xsl:element name="Name">
        <xsl:text>enable_product_validation</xsl:text>
      </xsl:element>
      <xsl:element name="Desc">
        Parameter to enable or disable product level validation during Deal Dependency checks. 1 means enabled, 0 means disabled.
      </xsl:element>
      <xsl:element name="Type">INT</xsl:element>
      <xsl:element name="Value">
        <xsl:choose>
          <xsl:when test="normalize-space(text()) = &apos;enabled&apos;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>0</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </xsl:element>
  </xsl:template>

 <xsl:template match="bc:MaxServicesToSearch">
    <xsl:element name="Param">
      <xsl:element name="Name">
        <xsl:text>max_services_to_search</xsl:text>
      </xsl:element>
      <xsl:element name="Desc">
         Parameter to configure the number of services to search in at a time during the retrieval of purchased offerings for a billinfo by the opcode PCM_OP_SUBSCRIPTION_GET_PURCHASED_OFFERINGS. Default is 5. Increasing the value might cause the select statement to fail, depending on the length of the poids involved in the search. 
      </xsl:element>
      <xsl:element name="Type">INT</xsl:element>
        <xsl:variable name="value" select="normalize-space(text())"/>
        <xsl:element name="Value">
        <xsl:value-of select="$value"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

 <xsl:template match="bc:CancelFullDiscountImmediate">
    <xsl:element name="Param">
      <xsl:element name="Name">
        <xsl:text>cancel_full_discount_immediate</xsl:text>
      </xsl:element>
      <xsl:element name="Desc">
        Parameter to enable or disable immediate cancellation of discount with proration setting of FULL. The posible values are 0(set end date to cycle end) and 1 (set end date and cancel the discount immediately). Default is 0.
      </xsl:element>
      <xsl:element name="Type">INT</xsl:element>
      <xsl:element name="Value">
        <xsl:choose>
          <xsl:when test="normalize-space(text()) = &apos;enabled&apos;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>0</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </xsl:element>
  </xsl:template>

 <xsl:template match="bc:TailormadeProductsSearch">
    <xsl:element name="Param">
      <xsl:element name="Name">
        <xsl:text>tailormade_products_search</xsl:text>
      </xsl:element>
      <xsl:element name="Desc">
        Parameter to enable or disable the search for tailormade products during the application of cycle fees. 1 means enabled, 0 means disabled. This parameter should be disabled only if advanced customization of products has not been used.
      </xsl:element>
      <xsl:element name="Type">INT</xsl:element>
      <xsl:element name="Value">
        <xsl:choose>
          <xsl:when test="normalize-space(text()) = &apos;enabled&apos;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>0</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </xsl:element>
  </xsl:template>

 <xsl:template match="bc:CancelledOfferingsSearch">
    <xsl:element name="Param">
      <xsl:element name="Name">
        <xsl:text>cancelled_offerings_search</xsl:text>
      </xsl:element>
      <xsl:element name="Desc">
        Parameter to enable or disable the search for cancelled offerings during billing. 1 means enabled, 0 means disabled.
      </xsl:element>
      <xsl:element name="Type">INT</xsl:element>
      <xsl:element name="Value">
        <xsl:choose>
          <xsl:when test="normalize-space(text()) = &apos;enabled&apos;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>0</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="bc:AllowBackdateNoRerate">
    <xsl:element name="Param">
      <xsl:element name="Name">
        <xsl:text>allow_backdate_with_no_rerate</xsl:text>
      </xsl:element>
      <xsl:element name="Desc">
        Parameter to allow backdating beyond the number of billing cycles specified in the cm pin.conf entry 'fm_subs num_billing_cycles', but without creating  the auto-rerate job. The possible values are 0 (Do not allow backdating beyond 'num_billing_cycles') and 1 (Allow backdating beyond 'num_billing_cycles' without creating auto-rerate job). Default is 0. 
      </xsl:element>
      <xsl:element name="Type">INT</xsl:element>
      <xsl:element name="Value">
        <xsl:choose>
          <xsl:when test="normalize-space(text()) = &apos;enabled&apos;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>0</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="bc:SubsDis74BackDateValidations">
    <xsl:element name="Param">
      <xsl:element name="Name">
        <xsl:text>subs_disable_74_backdated_validations</xsl:text>
      </xsl:element>
      <xsl:element name="Desc">
	Parameter to disable the backdated validations in 7.4. The possible values are 0 and 1. Default is 0. 
      </xsl:element>
      <xsl:element name="Type">INT</xsl:element>
      <xsl:element name="Value">
        <xsl:choose>
          <xsl:when test="normalize-space(text()) = &apos;enabled&apos;">
            <xsl:text>1</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>0</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
