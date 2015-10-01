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
				<ParamClass desc="Business logic parameters for Rerate" name="rerate">
					<xsl:apply-templates select="/bc:BusinessConfiguration/bc:BusParamConfigurationClass/bc:BusParamsRerate/bc:*"/>
				</ParamClass>
			</BusParamConfigurationList>
			</BusParamConfiguration>
		</BusinessConfiguration>
	</xsl:template>
		
	<xsl:template match="bc:BatchRatingPipeline">
		<xsl:element name="Param">
			<xsl:element name="Name">
				<xsl:text>batch_rating_pipeline</xsl:text>
			</xsl:element>
			<xsl:element name="Desc">
				Enable/Disable Indicates whether usage rating through the pipeline rating engine is enabled or disabled. The parameter values can be 0 (disabled), 1 (enabled). Default is 0 (disabled).
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

	<xsl:template match="bc:LineManagement">
		<xsl:element name="Param">
			<xsl:element name="Name">
				<xsl:text>line_management</xsl:text>
			</xsl:element>
			<xsl:element name="Desc">
				Rerate job creation will consider line transfer cases when enabled.
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

</xsl:stylesheet>
