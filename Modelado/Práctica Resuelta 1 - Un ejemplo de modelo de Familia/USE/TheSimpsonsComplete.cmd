-- INITIAL VALUES
!new Family('TheSimpsons')
!TheSimpsons.surname:='Simpson'

!new Person('homer')
!homer.name:='Homer'
!homer.age:=40
!homer.gender :=Gender::male

!new Person('marge')
!marge.name:='Marge'
!marge.age:=36
!marge.gender :=Gender::female

!new Person('bart')
!bart.name:='Bart'
!bart.age:=15
!bart.gender :=Gender::male

!new Person('lisa')
!lisa.name:='Lisa'
!lisa.age:=12
!lisa.gender :=Gender::female

!new Person('maggy')
!maggy.name:='Maggy'
!maggy.age:=4
!maggy.gender :=Gender::female

!insert (homer,TheSimpsons) into Fatherhood
!insert (marge,TheSimpsons) into Motherhood
!insert (lisa,TheSimpsons) into Childhood
!insert (bart,TheSimpsons) into Childhood
!insert (maggy,TheSimpsons) into Childhood

-------- 
!new Family('OlderSimpsons')
!OlderSimpsons.surname:='Simpson'

!new Person('abe')
!abe.name:='Abe'
!abe.age:=70
!abe.gender :=Gender::male

!new Person('mona')
!mona.name:='Mona'
!mona.age:=65
!mona.gender :=Gender::female

!new Person('herb')
!herb.name:='Herb'
!herb.age:=45
!herb.gender :=Gender::male

!insert (homer,OlderSimpsons) into Childhood
!insert (herb,OlderSimpsons) into Childhood
!insert (abe,OlderSimpsons) into Fatherhood
!insert (mona,OlderSimpsons) into Motherhood

-------------

!new Family('Bouviers')
!Bouviers.surname:='Bouvier'

!new Person('jackie')
!jackie.name:='Jackie'
!jackie.age:=80
!jackie.gender :=Gender::female

-- DECEASED
-- !new Person('clansy')
-- !clansy.name:='Clansy'
-- !clansy.age:=85
-- !clansy.gender :=Gender::male

!new Person('patty')
!patty.name:='Patty'
!patty.age:=40
!patty.gender :=Gender::female

!new Person('selma')
!selma.name:='Selma'
!selma.age:=40
!selma.gender :=Gender::female

!insert (jackie,Bouviers) into Motherhood
--!insert (clansy,Bouviers) into Fatherhood
!insert (marge,Bouviers) into Childhood
!insert (patty,Bouviers) into Childhood
!insert (selma,Bouviers) into Childhood

-----
!new Family('SelmaBouviers')
!Bouviers2.surname:='Bouvier'

!new Person('ling')
!ling.name:='Ling'
!ling.age:=12
!ling.gender :=Gender::female

!insert (selma,SelmaBouviers) into Motherhood
!insert (ling,SelmaBouviers) into Childhood

-- QUERIES

?homer.spouse()
?marge.spouse()
?homer.kids()
?lisa.grandParents()
