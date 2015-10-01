<?xml version="1.0" encoding="UTF-8"?>
 <!--
  ***************************************************************************
* Copyright (c) 2005, 2011, Oracle and/or its affiliates. All rights reserved. 
  * This material is the confidential property of Oracle Corporation or its *
  * licensors and may be used, reproduced, stored or transmitted only in    *
  * accordance with a valid Oracle license or sublicense agreement.         *
  ***************************************************************************
 -->

<xsl:stylesheet
	version="1.0" 
	xmlns="http://www.portal.com/schemas/BusinessConfig"
	xmlns:bc="http://www.portal.com/schemas/BusinessConfig"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="bc">
	
	<xsl:output method="xml" indent="yes"/>
	
	<xsl:template match="/">
		<BusinessConfiguration xmlns="http://www.portal.com/schemas/BusinessConfig" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.portal.com/schemas/BusinessConfig business_configuration.xsd">
			<BusParamConfiguration>
			<BusParamConfigurationList>
				<ParamClass desc="Business logic parameters for Invoicing" name="Invoicing">
					<xsl:apply-templates select="/bc:BusinessConfiguration/bc:BusParamConfigurationClass/bc:BusParamsInvoicing/bc:*"/>
				</ParamClass>
			</BusParamConfigurationList>
			</BusParamConfiguration>
		</BusinessConfiguration>
	</xsl:template>
	
	<xsl:template match="bc:ADSTTaxHandle">
		<xsl:element name="Param">
			<xsl:element name="Name">
				<xsl:text>ADST_Tax_Handle</xsl:text>
			</xsl:element>
			<xsl:element name="Desc">
				Enable/Disable ADST Tax handling Feature for Invoicing. 
				Parameter values can be 0 (disable), 1 (enable). Default is 0 (disabled).
			</xsl:element>
			<xsl:element name="Type">INT</xsl:element>
			<xsl:element name="Value">
				<xsl:choose>
					<xsl:when test="normalize-space(text()) = 'enabled'">
						<xsl:text>1</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>0</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="bc:ThresholdSubordsSummary">
		<xsl:element name="Param">
			<xsl:element name="Name">
				<xsl:text>threshold_subords_summary</xsl:text>
			</xsl:element>
			<xsl:element name="Desc">
				Threshold for number of subordinates for summary invoices.
				(0=default(no split invoices for hierarchy))
			</xsl:element>
			<xsl:element name="Type">INT</xsl:element>
			<xsl:variable name="value" select="normalize-space(text())"/>
			<xsl:element name="Value">
				<xsl:value-of select="$value"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="bc:ThresholdSubordsDetail">
		<xsl:element name="Param">
			<xsl:element name="Name">
				<xsl:text>threshold_subords_detail</xsl:text>
			</xsl:element>
			<xsl:element name="Desc">
				Threshold for number of subordinates for detail invoice.
				(0=default(no split invoices for hierarchy))
			</xsl:element>
			<xsl:element name="Type">INT</xsl:element>
			<xsl:variable name="value" select="normalize-space(text())"/>
			<xsl:element name="Value">
				<xsl:value-of select="$value"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bc:SubARItemsIncluded">
		<xsl:element name="Param">
			<xsl:element name="Name">
				<xsl:text>sub_ar_items_included</xsl:text>
			</xsl:element>
			<xsl:element name="Desc">
				Indicates whether Subordinate account invoice includes AR items or not.
				(0- default , AR items not included and 1 - AR items included)
			</xsl:element>
			<xsl:element name="Type">INT</xsl:element>
			<xsl:element name="Value">
				<xsl:choose>
					<xsl:when test="normalize-space(text()) = 'enabled'">
						<xsl:text>1</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>0</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:element>
	</xsl:template>

        <xsl:template match="bc:PromotionDetailDisplay">
                <xsl:element name="Param">
                        <xsl:element name="Name">
                                <xsl:text>promotion_detail_display</xsl:text>
                        </xsl:element>
                        <xsl:element name="Desc">
                                Indicates whether promotion details should be shown on the invoice.
                                (1- default , show promotion details and 0 - Do not show promotion details)
                        </xsl:element>
                        <xsl:element name="Type">INT</xsl:element>
                        <xsl:element name="Value">
                                <xsl:choose>
                                        <xsl:when test="normalize-space(text()) = 'enabled'">
                                                <xsl:text>1</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                                <xsl:text>0</xsl:text>
                                        </xsl:otherwise>
                                </xsl:choose>
                        </xsl:element>
                </xsl:element>
        </xsl:template>
	
	<xsl:template match="bc:EnableInvoicingIntegration">
                <xsl:element name="Param">
                        <xsl:element name="Name">
                                <xsl:text>enable_invoicing_integration</xsl:text>
                        </xsl:element>
                        <xsl:element name="Desc">
				Enable/Disable BRM-BIP integration for final invoice document generation.
				Parameter values can be 0 (disable), 1 (enable). Default is 0 (disabled)	
                        </xsl:element>
                        <xsl:element name="Type">INT</xsl:element>
                        <xsl:element name="Value">
                                <xsl:choose>
                                        <xsl:when test="normalize-space(text()) = 'enabled'">
                                                <xsl:text>1</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                                <xsl:text>0</xsl:text>
                                        </xsl:otherwise>
                                </xsl:choose>
                        </xsl:element>
                </xsl:element>
        </xsl:template>

	<xsl:template match="bc:InvoiceStorageType">
                <xsl:element name="Param">
                        <xsl:element name="Name">
                                <xsl:text>invoice_storage_type</xsl:text>
                        </xsl:element>
                        <xsl:element name="Desc">
                               	Format of invoice which needs to be stored in BRM database.
				Parameter values can be 0 (flist), 1 (xml). Default is 0 (flist)	 
                        </xsl:element>
                        <xsl:element name="Type">INT</xsl:element>
                        <xsl:variable name="value" select="normalize-space(text())"/>
                        <xsl:element name="Value">
                                <xsl:value-of select="$value"/>
                        </xsl:element>

                </xsl:element>
        </xsl:template>

	<xsl:template match="bc:InOperatorSize">
                <xsl:element name="Param">
                        <xsl:element name="Name">
                                <xsl:text>in_operator_size</xsl:text>
                        </xsl:element>
                        <xsl:element name="Desc">
				IN operator size in sql statement limited by string length.
				Parameter values can be based on database capacity. 
				Default value is 500.The value can be less than 500 but cannot be greater than 500.
                        </xsl:element>
                        <xsl:element name="Type">INT</xsl:element>
                        <xsl:variable name="value" select="normalize-space(text())"/>
                        <xsl:element name="Value">
                                <xsl:value-of select="$value"/>
                        </xsl:element>

                </xsl:element>
        </xsl:template>

</xsl:stylesheet>
