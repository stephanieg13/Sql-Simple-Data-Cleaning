select *
from NashvilleHousing

--change Sale Date format 

select SaleDate, CONVERT(date,SaleDate) 
from NashvilleHousing

Update NashvilleHousing
set SaleDate = CONVERT(date,SaleDate) 

--Populating Property Address data using already populated parcelID of the same address without changing unique address

select *
from NashvilleHousing
where PropertyAddress is null

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
	on a.ParcelID =b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ] 
where a.PropertyAddress is null

update a 
set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
	on a.ParcelID =b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ] 
where a.PropertyAddress is null


--Address into separate columns based on: address, city, and state

select *
from NashvilleHousing

select PropertyAddress
from NashvilleHousing

select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, len(PropertyAddress)) as Address
from NashvilleHousing

Alter table NashvilleHousing
Add SplitPropertyAddress nvarchar(255); 

Update NashvilleHousing
set SplitPropertyAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)


Alter table NashvilleHousing
Add SplitPropertyCity nvarchar(255);

Update NashvilleHousing
set SplitPropertyCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, len(PropertyAddress))


select * 
from NashvilleHousing




select OwnerAddress 
from NashvilleHousing

select 
PARSENAME(Replace(OwnerAddress, ',', '.'), 3)
,PARSENAME(Replace(OwnerAddress, ',', '.'), 2)
,PARSENAME(Replace(OwnerAddress, ',', '.'), 1)
from NashvilleHousing


Alter table NashvilleHousing
Add SplitOwnerAddress nvarchar(255); 

Update NashvilleHousing
set SplitOwnerAddress = PARSENAME(Replace(OwnerAddress, ',', '.'), 3)


Alter table NashvilleHousing
Add SplitOwnerCity nvarchar(255);

Update NashvilleHousing
set SplitOwnerCity = PARSENAME(Replace(OwnerAddress, ',', '.'), 2)


Alter table NashvilleHousing
Add SplitOwnerState nvarchar(255); 

Update NashvilleHousing
set SplitOwnerState = PARSENAME(Replace(OwnerAddress, ',', '.'), 1)

select *
from NashvilleHousing



--Remove abbreviations for 'yes' and 'no' in Sold as Vacant column 

select *
from NashvilleHousing

select distinct(SoldAsVacant), COUNT(SoldAsVacant)
from NashvilleHousing
group by SoldAsVacant
order by 2



select SoldAsVacant
, case when SoldAsVacant = 'Y' then 'Yes'
		when SoldAsVacant = 'N' then 'No'
		else SoldAsVacant
		end
from NashvilleHousing

update NashvilleHousing
set SoldAsVacant = case when SoldAsVacant = 'Y' then 'Yes'
		when SoldAsVacant = 'N' then 'No'
		else SoldAsVacant
		end



--Deleting Columns (for views)

select *
from NashvilleHousing

Alter table NashvilleHousing
Drop column PropertyAddress, OwnerAddress, SaleDate, TaxDistrict

