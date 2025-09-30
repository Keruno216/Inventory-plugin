// Fill out your copyright notice in the Description page of Project Settings.


#include "InventoryManagement/Utils/Inv_InventoryStatics.h"

UInv_InventoryComponent* UInv_InventoryStatics::GetInventoryComponent(const APlayerController* PlayerController)
{
	if (!IsValid(PlayerController))
	{
		return nullptr;
	}
	UInv_InventoryComponent* InventoryComponent = PlayerController->FindComponentByClass<UInv_InventoryComponent>();
	return InventoryComponent;
}
