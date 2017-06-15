USE [FINANCIERAAPP]
GO

/****** Object:  View [dbo].[xvr_xCustomerSL_Opportunity]    Script Date: 15/06/2017 11:35:23 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








ALTER VIEW [dbo].[xvr_xCustomerSL_Opportunity]
AS
select 
'Cliente' Cliente_Aval
,A.PKCustomerSL
,B.PKOportunity
,XO.OpportunityId
,XO.new_Nombre 
,XO.new_SegundoNombre
,XO.new_Apellidos
,XO.new_ApellidoMaterno
,XO.new_ApellidoAdicional
,XO.new_fECHADENACIMIENTO
,XO.new_RFC
,xo.new_StatusdeVivienda
,xo.new_Identificacion
,xo.new_foliodeidentificacion
,xo.new_estadocivil
,xo.new_sexo
,xo.new_curp
,CONVERT(VARCHAR(50),(CASE WHEN ltrim(rtrim(XO.new_dependienteseconomicos)) LIKE '[0-9]' 
 THEN XO.new_dependienteseconomicos ELSE
 '' END), 103) as 'new_dependienteseconomicos'
,xo.new_Fechadecontratacion
,(xo.new_domicilio + ' ' + xo.new_numero) domicilio
,d.new_name new_colonia
,(CASE WHEN C.new_municipiodelegacion is null then c.new_name
 else c.new_municipiodelegacion end) as 'new_ciudad'
,xo.new_cptext
,xo.new_telefonocasa
,xo.new_numcontrato
,e.new_estadoburocredito 
,'' as 'new_personalidad'
from PaymentsCustomer A
LEFT OUTER JOIN PaymentsOportunity B ON A.PKCustomer = B.FKCliente
LEFT OUTER JOIN  HERMES.CREDIJAL_MSCRM.dbo.OpportunityBase XO 
		ON XO.OpportunityId 
		--collate SQL_Latin1_General_CP1_CI_AS  
		= 
		B.PKOportunity --collate  SQL_Latin1_General_CP1_CI_AS
left outer join HERMES.CREDIJAL_MSCRM.dbo.new_ciudad c on xo.new_ciudad = c.new_ciudadId
left outer join HERMES.CREDIJAL_MSCRM.dbo.new_colonia d on xo.new_Colonia = d.new_coloniaId
LEFT OUTER JOIN HERMES.CREDIJAL_MSCRM.dbo.new_ESTADOs e ON xo.NEW_ESTADO = e.new_estadosId
union all 
--Avales 
select 
'Aval' Cliente_Aval
,A.PKCustomerSL
,B.PKOportunity
,XO.new_Oportunidad
,XO.new_Name as 'new_Nombre'
,XO.new_SegundoNombre
,XO.new_ApellidoPaterno --+ ' ' + new_ApellidoMaterno
,XO.new_ApellidoMaterno
,XO.new_ApellidoAdicional
,XO.new_fECHADENACIMIENTO
,XO.new_RFC
,xo.new_EstatusdeVivienda
,xo.new_Identificacion
,xo.new_foliodeidentificacion
,xo.new_estadocivil
,xo.new_sexo
,xo.new_curp
,CONVERT(VARCHAR(50),(CASE WHEN ltrim(rtrim(XO.new_dependienteseconomicos)) LIKE '[0-9]' 
 THEN XO.new_dependienteseconomicos ELSE
 '' END), 103) as 'new_dependienteseconomicos'
,(select top 1 a.new_Fechadecontratacion from HERMES.CREDIJAL_MSCRM.dbo.OpportunityBase a where a.OpportunityId = xo.new_Oportunidad) as new_Fechadecontratacion
,(xo.new_domicilio 
--+ ' ' + xo.new_numero
) domicilio
,d.new_name new_colonia
,(CASE WHEN C.new_municipiodelegacion is null then c.new_name
 else c.new_municipiodelegacion end) as 'new_ciudad'
,xo.new_CP
,xo.new_telefonocasa
,(select top 1 a.new_numcontrato from HERMES.CREDIJAL_MSCRM.dbo.OpportunityBase a where a.OpportunityId = xo.new_Oportunidad) as 'new_numcontrato' 
,e.new_estadoburocredito 
,xo.new_personalidad
from PaymentsCustomer A
LEFT OUTER JOIN PaymentsOportunity B ON A.PKCustomer = B.FKCliente
LEFT OUTER JOIN  HERMES.CREDIJAL_MSCRM.dbo.new_aval XO 
		ON XO.new_Oportunidad 
		--collate SQL_Latin1_General_CP1_CI_AS  
		= 
		B.PKOportunity --collate  SQL_Latin1_General_CP1_CI_AS
		--where B.PKOportunity = '{92B65BE0-00D9-E611-80EA-00155D6D0604}'
left outer join HERMES.CREDIJAL_MSCRM.dbo.new_ciudad c on xo.new_ciudad = c.new_ciudadId
left outer join HERMES.CREDIJAL_MSCRM.dbo.new_colonia d on xo.new_Colonia = d.new_coloniaId
LEFT OUTER JOIN HERMES.CREDIJAL_MSCRM.dbo.new_ESTADOs e ON xo.NEW_ESTADO = e.new_estadosId







GO


