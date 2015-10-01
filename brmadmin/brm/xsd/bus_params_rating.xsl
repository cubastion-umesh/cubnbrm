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
				<ParamClass desc="Business logic parameters for Rating" name="rating">
					<xsl:apply-templates select="/bc:BusinessConfiguration/bc:BusParamConfigurationClass/bc:BusParamsRating/bc:*"/>
				</ParamClass>
			</BusParamConfigurationList>
			</BusParamConfiguration>
		</BusinessConfiguration>
	</xsl:template>
	
	<xsl:template match="bc:OverrideCreditLimit">
		<xsl:element name="Param">
			<xsl:element name="Name">
				<xsl:text>override_credit_limit</xsl:text>
			</xsl:element>
			<xsl:element name="Desc">
				This parameter decides if the 
				system-wide credit limit override
				feature is enabled. When enabled by setting 
				to 1, credit limit check is avoided 
				irrespective of the credit limit 
				override value set in the product. 
				Default value is 0 which disables this feature.
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
	<xsl:template match="bc:EnableEras">
		<xsl:element name="Param">
			<xsl:element name="Name">
				<xsl:text>enable_eras</xsl:text>
			</xsl:element>
			<xsl:element name="Desc">
				This configuration can be used to control the selection of ERAs from profile
				objects.
				The values supported for this configuration parameter are:
				0 - disabled (no profiles)
				1 - service (select ERAs from service profiles only)
				2 - account (select ERAs from account profiles only)
				3 - service and account  (select ERAs from service and account profiles)
				The default value for this configuration parameter is 3.
				Also, if this parameter is not specified the implicit behavior is the default behavior.
			</xsl:element>
			<xsl:element name="Type">INT</xsl:element>
			<xsl:element name="Value">
				<xsl:choose>
					<xsl:when test="normalize-space(text()) = 'serviceAndAccount'">
						<xsl:text>3</xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space(text()) = 'account'">
						<xsl:text>2</xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space(text()) = 'service'">
						<xsl:text>1</xsl:text>
					</xsl:when>
					<xsl:when test="normalize-space(text()) = 'disabled'">
						<xsl:text>0</xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="bc:EnableTailormadeCache">
		<xsl:element name="Param">
			<xsl:element name="Name">
				<xsl:text>enable_tailormade_cache</xsl:text>
			</xsl:element>
			<xsl:element name="Desc">
				This parameter decides if the
				tailormade products need to be stored
				in the cache of C Rating Engine.
				When enabled by setting to 1,
				tailormade products are stored in the cache.
				Default value is 0 which disables this feature.
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
        <xsl:template match="bc:EnableGlobalChargeSharing">
                <xsl:element name="Param">
                        <xsl:element name="Name">
                                <xsl:text>enable_global_charge_sharing</xsl:text>
                        </xsl:element>
                        <xsl:element name="Desc">
				This parameter enables or disables
				Global charge sharing.This is enabled by setting to 1.
                                Default value is 0 which disables this feature.			
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
        <xsl:template match="bc:AllocateReratingAdjustments">
                <xsl:element name="Param">
                        <xsl:element name="Name">
                                <xsl:text>allocate_rerating_adjustments</xsl:text>
                        </xsl:element>
                        <xsl:element name="Desc">
				This parameter indicates that the item adjustments which are created by the rerating process will be allocated to billable items. The parameter has two values: 0 - do not make allocatioin during rerating (default), or 1 - make allocation during rerating.
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
	<xsl:template match="bc:ProductsDiscountsThreshold">
                <xsl:element name="Param">
                        <xsl:element name="Name">
                                <xsl:text>products_discounts_threshold</xsl:text>
                        </xsl:element>
                        <xsl:element name="Desc">
				This paramater indicates the maximum number of products or discounts that
				will be cached in C Rating Engine cache. Once the specified value is reached
				for either products/discounts then 10% of the products or discounts that are
				least used will be flushed from the cache. This is applicable only if this
				parameter is non-zero. Default value is 0 which disables this feature.
                        </xsl:element>
                        <xsl:element name="Type">INT</xsl:element>
                        <xsl:variable name="value" select="normalize-space(text())"/>
                        <xsl:element name="Value">
                                <xsl:value-of select="$value"/>
                        </xsl:element>
                </xsl:element>
        </xsl:template>
</xsl:stylesheet>
