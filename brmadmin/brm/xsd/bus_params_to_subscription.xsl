<?xml version="1.0" encoding="UTF-8"?>
 <!--
   **************************************************************************
* Copyright (c) 2005, 2011, Oracle and/or its affiliates. All rights reserved. 
  *
  * This material is the confidential property of Oracle Corporation
  * or its licensors and may be used, reproduced, stored or transmitted
  * only in accordance with a valid Oracle license or sublicense agreement.
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
      <BusParamConfigurationClass>
        <BusParamsSubscription>
          <xsl:apply-templates select="/bc:BusinessConfiguration/bc:BusParamConfiguration/bc:BusParamConfigurationList/bc:ParamClass/bc:Param"/>
        </BusParamsSubscription>
      </BusParamConfigurationClass>
    </BusinessConfiguration>
  </xsl:template>

  <xsl:template match="//bc:Param">

    <xsl:variable name="name">
      <xsl:value-of select="bc:Name/text()"/>
    </xsl:variable>

    <xsl:variable name="value">
      <xsl:value-of select="bc:Value/text()"/>
    </xsl:variable>

    <xsl:choose>

      <xsl:when test="$name = &apos;discount_based_on_contract_days_feature&apos;">
        <xsl:element name="DiscountBasedOnContractDaysFeature">
          <xsl:choose>
            <xsl:when test="$value = &apos;1&apos;">
              <xsl:text>enabled</xsl:text>
            </xsl:when>
            <xsl:when test="$value = &apos;0&apos;">
              <xsl:text>disabled</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:element>
      </xsl:when>

      <xsl:when test="$name = &apos;best_pricing&apos;">
        <xsl:element name="BestPricing">
          <xsl:choose>
            <xsl:when test="$value = &apos;1&apos;">
              <xsl:text>enabled</xsl:text>
            </xsl:when>
            <xsl:when test="$value = &apos;0&apos;">
              <xsl:text>disabled</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:element>
      </xsl:when>

      <xsl:when test="$name = &apos;rollover_transfer&apos;">
        <xsl:element name="RolloverTransfer">
          <xsl:choose>
            <xsl:when test="$value = &apos;1&apos;">
              <xsl:text>enabled</xsl:text>
            </xsl:when>
            <xsl:when test="$value = &apos;0&apos;">
              <xsl:text>disabled</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:element>
      </xsl:when>

      <xsl:when test="$name = &apos;automated_monitor_setup&apos;">
        <xsl:element name="AutomatedMonitorSetup">
          <xsl:choose>
            <xsl:when test="$value = &apos;1&apos;">
              <xsl:text>enabled</xsl:text>
            </xsl:when>
            <xsl:when test="$value = &apos;0&apos;">
              <xsl:text>disabled</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:element>
      </xsl:when>

      <xsl:when test="$name = &apos;enable_product_validation&apos;">
        <xsl:element name="EnableProductValidation">
          <xsl:choose>
            <xsl:when test="$value = &apos;1&apos;">
              <xsl:text>enabled</xsl:text>
            </xsl:when>
            <xsl:when test="$value = &apos;0&apos;">
              <xsl:text>disabled</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:element>
      </xsl:when>

      <xsl:when test="$name = &apos;max_services_to_search&apos;">
        <xsl:element name="MaxServicesToSearch">
          <xsl:value-of select="$value"/>
        </xsl:element>
      </xsl:when>

      <xsl:when test="$name = &apos;cancel_full_discount_immediate&apos;">
        <xsl:element name="CancelFullDiscountImmediate">
          <xsl:choose>
            <xsl:when test="$value = &apos;1&apos;">
              <xsl:text>enabled</xsl:text>
            </xsl:when>
            <xsl:when test="$value = &apos;0&apos;">
              <xsl:text>disabled</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:element>
      </xsl:when>

      <xsl:when test="$name = &apos;tailormade_products_search&apos;">
        <xsl:element name="TailormadeProductsSearch">
          <xsl:choose>
            <xsl:when test="$value = &apos;1&apos;">
              <xsl:text>enabled</xsl:text>
            </xsl:when>
            <xsl:when test="$value = &apos;0&apos;">
              <xsl:text>disabled</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:element>
      </xsl:when>

      <xsl:when test="$name = &apos;cancelled_offerings_search&apos;">
        <xsl:element name="CancelledOfferingsSearch">
          <xsl:choose>
            <xsl:when test="$value = &apos;1&apos;">
              <xsl:text>enabled</xsl:text>
            </xsl:when>
            <xsl:when test="$value = &apos;0&apos;">
              <xsl:text>disabled</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:element>
      </xsl:when>

      <xsl:when test="$name = &apos;allow_backdate_with_no_rerate&apos;">
        <xsl:element name="AllowBackdateNoRerate">
          <xsl:choose>
            <xsl:when test="$value = &apos;1&apos;">
              <xsl:text>enabled</xsl:text>
            </xsl:when>
            <xsl:when test="$value = &apos;0&apos;">
              <xsl:text>disabled</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:element>
      </xsl:when>

      <xsl:when test="$name = &apos;subs_disable_74_backdated_validations&apos;">
        <xsl:element name="SubsDis74BackDateValidations">
          <xsl:choose>
            <xsl:when test="$value = &apos;1&apos;">
              <xsl:text>enabled</xsl:text>
            </xsl:when>
            <xsl:when test="$value = &apos;0&apos;">
              <xsl:text>disabled</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:element>
      </xsl:when>

    </xsl:choose>

  </xsl:template>

</xsl:stylesheet>
