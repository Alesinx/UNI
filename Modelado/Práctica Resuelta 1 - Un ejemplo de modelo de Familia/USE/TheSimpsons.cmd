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

-- QUERIES

?homer.spouse()
?marge.spouse()
?homer.kids()
?lisa.grandParents()
