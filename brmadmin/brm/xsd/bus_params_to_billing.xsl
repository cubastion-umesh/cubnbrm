<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns="http://www.portal.com/schemas/BusinessConfig" xmlns:bc="http://www.portal.com/schemas/BusinessConfig" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="bc">
	
	<xsl:output method="xml" indent="yes"/>
	
	<xsl:template match="/">
		<BusinessConfiguration xmlns="http://www.portal.com/schemas/BusinessConfig" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.portal.com/schemas/BusinessConfig business_configuration.xsd">
			<BusParamConfigurationClass>
				<BusParamsBilling>
					<xsl:apply-templates select="/bc:BusinessConfiguration/bc:BusParamConfiguration/bc:BusParamConfigurationList/bc:ParamClass/bc:Param"/>
				</BusParamsBilling>
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

				<xsl:when test="$name = &apos;billing_cycle_offset&apos;">
					<xsl:element name="BillingCycleOffset">
						<xsl:value-of select="$value"/>
					</xsl:element>
				</xsl:when>
				
				<xsl:when test="$name = &apos;move_day_forward&apos;">
					<xsl:element name="MoveDayForward">
						<xsl:choose>
							<xsl:when test="$value = &apos;1&apos;">
								<xsl:text>firstDay</xsl:text>
							</xsl:when>
							<xsl:when test="$value = &apos;0&apos;">
								<xsl:text>lastDay</xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:element>
				</xsl:when>

				<xsl:when test="$name = &apos;remove_sponsoree&apos;">
					<xsl:element name="RemoveSponsoree">
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

				<xsl:when test="$name = &apos;prod_end_offset_plan_transition&apos;">
					<xsl:element name="ProdEndOffsetPlanTransition">
						<xsl:value-of select="$value"/>
					</xsl:element>
				</xsl:when>

				<xsl:when test="$name = &apos;generate_journal_epsilon&apos;">
					<xsl:element name="GenerateJournalEpsilon">
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

				<xsl:when test="$name = &apos;apply_cycle_fees_for_bill_now&apos;">
					<xsl:element name="ApplyCycleFeeForBillNow">
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

				<xsl:when test="$name = &apos;generate_corrective_bill_no&apos;">
					<xsl:element name="GenerateCorrectiveBillNo">
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

				<xsl:when test="$name = &apos;enable_corrective_invoices&apos;">
					<xsl:element name="EnableCorrectiveInvoices">
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

				<xsl:when test="$name = &apos;allow_corrective_paid_bills&apos;">
					<xsl:element name="AllowCorrectivePaidBills">
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

				<xsl:when test="$name = &apos;reject_payments_for_previous_bill&apos;">
					<xsl:element name="RejectPaymentsForPreviousBill">
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

				<xsl:when test="$name = &apos;corrective_bill_threshold&apos;">
					<xsl:element name="CorrectiveBillThreshold">
						<xsl:value-of select="$value"/>
					</xsl:element>
				</xsl:when>

				<xsl:when test="$name = &apos;rerate_during_billing&apos;">
					<xsl:element name="RerateDuringBilling">
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

				<xsl:when test="$name = &apos;auto_triggering_limit&apos;">
					<xsl:element name="AutoTriggeringLimit">
						<xsl:value-of select="$value"/>
					</xsl:element>
				</xsl:when>

				<xsl:when test="$name = &apos;validate_discount_dependency&apos;">
					<xsl:element name="ValidateDiscountDependency">
						<xsl:choose>
							<xsl:when test="$value = &apos;0&apos;">
								<xsl:text>disabled</xsl:text>
							</xsl:when>
							<xsl:when test="$value = &apos;1&apos;">
								<xsl:text>discToDiscExcl</xsl:text>
							</xsl:when>
							<xsl:when test="$value = &apos;2&apos;">
								<xsl:text>discToPlanExcl</xsl:text>
							</xsl:when>
							<xsl:when test="$value = &apos;3&apos;">
								<xsl:text>enableBothExcl</xsl:text>
							</xsl:when>
							<xsl:when test="$value = &apos;4&apos;">
								<xsl:text>disableDiscToPlanExclAndNoPurTimeValidation</xsl:text>
							</xsl:when>
							<xsl:when test="$value = &apos;7&apos;">
								<xsl:text>enableBothExclAndNoPurTimeValidation</xsl:text>
							</xsl:when>
							<xsl:when test="$value = &apos;8&apos;">
								<xsl:text>returnOnFirstExcl</xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:element>
				</xsl:when>

				<xsl:when test="$name = &apos;rollover_correction_during_billing&apos;">
					<xsl:element name="RolloverCorrectionDuringBilling">
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

				<xsl:when test="$name = 'enable_ara'">
                                        <xsl:element name="EnableARA">
                                        <xsl:choose>
                                                        <xsl:when test="$value = '1'">
                                                                <xsl:text>enabled</xsl:text>
                                                        </xsl:when>
                                                        <xsl:when test="$value = '0'">
                                                                <xsl:text>disabled</xsl:text>
                                                        </xsl:when>
                                                </xsl:choose>
                                        </xsl:element>
                                </xsl:when>
				
				<xsl:when test="$name = 'create_two_bill_now_bills_in_delay'">
                                        <xsl:element name="CreateTwoBillNowBillsInDelay">
                                        <xsl:choose>
                                                        <xsl:when test="$value = '1'">
                                                                <xsl:text>enabled</xsl:text>
                                                        </xsl:when>
                                                        <xsl:when test="$value = '0'">
                                                                <xsl:text>disabled</xsl:text>
                                                        </xsl:when>
                                                </xsl:choose>
                                        </xsl:element>
                                </xsl:when>

				<xsl:when test="$name = &apos;sub_bal_validity&apos;">
                                        <xsl:element name="SubBalValidity">
                                                <xsl:choose>
                                                        <xsl:when test="$value = &apos;0&apos;">
                                                                <xsl:text>Cut</xsl:text>
                                                        </xsl:when>
                                                        <xsl:when test="$value = &apos;1&apos;">
                                                                <xsl:text>Maintain</xsl:text>
                                                        </xsl:when>
                                                        <xsl:when test="$value = &apos;2&apos;">
                                                                <xsl:text>Align</xsl:text>
                                                        </xsl:when>
                                                </xsl:choose>
                                        </xsl:element>
                                </xsl:when>

				
                                <xsl:when test="$name = &apos;sequential_cycle_discounting&apos;">
                                        <xsl:element name="SequentialCycleDiscounting">
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
				
				<xsl:when test="$name = 'cache_residency_distinction'">
					<xsl:element name="CacheResidencyDistinction">
						<xsl:choose>
							<xsl:when test="$value = '1'">
								<xsl:text>enabled</xsl:text>
							</xsl:when>
							<xsl:when test="$value = '0'">
								<xsl:text>disabled</xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:element>
				</xsl:when>

				<xsl:when test="$name = &apos;default_business_profile&apos;">
                                        <xsl:element name="DefaultBusinessProfile">
                                                <xsl:choose>
                                                        <xsl:when test="$value = 'Convergent'">
                                                                <xsl:text>Convergent</xsl:text>
                                                        </xsl:when>
                                                        <xsl:when test="$value = 'Prepaid'">
                                                                <xsl:text>Prepaid</xsl:text>
                                                        </xsl:when>
                                                        <xsl:when test="$value = 'Postpaid'">
                                                                <xsl:text>Postpaid</xsl:text>
                                                        </xsl:when>
                                                        <xsl:when test="$value = 'Nonusage'">
                                                                <xsl:text>Nonusage</xsl:text>
                                                        </xsl:when>
                                                </xsl:choose>
                                        </xsl:element>
                                </xsl:when>

				<xsl:when test="$name = &apos;custom_journal_update&apos;">
					<xsl:element name="CustomJournalUpdate">
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
