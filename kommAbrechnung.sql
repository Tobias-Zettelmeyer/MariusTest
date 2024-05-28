SELECT
			p.PSPERSNR Personalnummer --p = Perstamm
			, bu.BUDATE BUCHDATUM --bu = BUCHTAG
			, bu.BUJAHR JAHR
			, bu.BUMONAT MONAT
			, bu.BUISTS ISTSTUNDEN
			, bu.BUISTM ISTMINUTEN
			, bu.BUGLEIZE MEHRMINUTEN
			, isnull((	select 
					sum(sub1.UESTERGS) --ueberstunden gesamt
				from 
					UEBSTUND sub1
				WHERE
					sub1.PSNR=p.PSNR
					and sub1.UESTDATE=bu.BUDATE
					and sub1.REGNR=6), 0) NACHTSTUNDEN --check ob nachtstunden, if null set to 0
			, isnull((	select 
					sum(sub1.UESTERGM) 
				from 
					UEBSTUND sub1
				WHERE
					sub1.PSNR=p.PSNR
					and sub1.UESTDATE=bu.BUDATE
					and sub1.REGNR=6), 0) NACHTMINUTEN --check ob nachtminuten, if null set to 

			, isnull((select 
					 sum(sub2.ZKSONNTG)
				from 
					ZEITKONT as sub2
				WHERE
					sub2.PSNR=p.PSNR), 0) SONNTAGSSTUNDEN

			, isnull((select 
					sum(sub2.ZKFEIETG)
				from 
					ZEITKONT as sub2
				WHERE
				sub2.PSNR=p.PSNR), 0) FEIERTAGSSTUNDEN
					--and sub2.UESTDATE=bu.BUDATE
					--and sub2.REGNR=6), 0) 
		FROM
			 BUCHTAG bu
			,PERSTAMM p
			
		WHERE
			bu.PSNR=p.PSNR
			and p.PSPERSNR = '3792'
			and bu.BUDATE > 20230300
			and bu.BUDATE < 20240300
			