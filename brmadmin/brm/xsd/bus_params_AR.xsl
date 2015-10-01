<?xml version="1.0" encoding="UTF-8"?>

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
				<ParamClass desc="Business logic parameters for AR" name="ar">
					<xsl:apply-templates select="/bc:BusinessConfiguration/bc:BusParamConfigurationClass/bc:BusParamsAR/bc:*"/>
				</ParamClass>
			</BusParamConfigurationList>
			</BusParamConfiguration>
		</BusinessConfiguration>
	</xsl:template>
	
	<xsl:template match="bc:SearchBillAmount">
		<xsl:element name="Param">
			<xsl:element name="Name">
				<xsl:text>search_bill_amount_enable</xsl:text>
			</xsl:element>
			<xsl:element name="Desc">
				Enable/Disable Search of Bill Object by matching Bill Amount. The parameter values can be 0 (disabled), 1 (enabled). Default is 0 (disabled).
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
	
	
	<xsl:template match="bc:AutoWriteOffReversal">
		<xsl:element name="Param">
			<xsl:element name="Name">
				<xsl:text>auto_writeoff_reversal_enable</xsl:text>
			</xsl:element>
			<xsl:element name="Desc">
				Enable/Disable automatic write-off reversal on Payment receipt.The Parameter values can be 0 (disabled), 1 (enabled). Default is 0 (disabled).
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
	
	<xsl:template match="bc:WriteOffLevel">
		<xsl:element name="Param">
			<xsl:element name="Name">
				<xsl:text>writeoff_level</xsl:text>
			</xsl:element>
			<xsl:element name="Desc">
				Level of writeoff to be tracked for the purpose of writeoff reversal.Default is account and currently only account level is supported.
			</xsl:element>
			<xsl:element name="Type">STR</xsl:element>
			<xsl:element name="Value">
				<xsl:choose>
					<xsl:when test="normalize-space(text()) = 'account'">
						<xsl:text>account</xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:element>
		</xsl:element>
	</xsl:template>

<xsl:template match="bc:PaymentIncentive">
	<xsl:element name="Param">
		<xsl:element name="Name">
			<xsl:text>payment_incentive_enable</xsl:text>
		</xsl:element>
		<xsl:element name="Desc">
			Enable/Disable Payment incentives on early payment in full. The parameter values can be 0 (disabled), 1 (enabled). Default is 0 (disabled).
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
	
	<xsl:template match="bc:PaymentSuspense">
		<xsl:element name="Param">
			<xsl:element name="Name">
				<xsl:text>payment_suspense_enable</xsl:text>
			</xsl:element>
			<xsl:element name="Desc">
				Enable/Disable Payment Suspense Management . The parameter values can be 0 (disabled), 1 (enabled). Default is 0 (disabled).
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

	<xsl:template match="bc:NonrefundableCreditItems">
                <xsl:element name="Param">
                        <xsl:element name="Name">
                                <xsl:text>nonrefundable_credit_items</xsl:text>
                        </xsl:element>
                        <xsl:element name="Desc">
				Types of items which will NOT be refunded in case of outstanding credit balance.
The values should be separated by commas. Default is /item/refund .
                        </xsl:element>
                        <xsl:element name="Type">STR</xsl:element>
			<xsl:element name="Value">
				<xsl:variable name="value">
					<xsl:value-of select="normalize-space(text())"></xsl:value-of>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$value">
						<xsl:value-of select="$value" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'/item/refund'" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
                </xsl:element>
        </xsl:template>

</xsl:stylesheet>
