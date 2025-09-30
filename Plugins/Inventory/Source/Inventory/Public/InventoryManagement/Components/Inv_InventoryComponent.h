// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "Components/ActorComponent.h"
#include "Inv_InventoryComponent.generated.h"

DECLARE_DYNAMIC_MULTICAST_DELEGATE_OneParam(FInventoryItemChange, UInv_InventoryItem*, Item);

DECLARE_DYNAMIC_MULTICAST_DELEGATE(FNoRoomInInventory);

UCLASS(ClassGroup=(Custom), meta=(BlueprintSpawnableComponent), Blueprintable)
class INVENTORY_API UInv_InventoryComponent : public UActorComponent
{
	GENERATED_BODY()

public:
	UInv_InventoryComponent();

	UFUNCTION(BlueprintCallable, BlueprintAuthorityOnly, Category="Inventory")
	void TryAddItem(UInv_ItemComponent* ItemComponent);

	void ToggleInventoryMenu();

	FInventoryItemChange OnItemAdded;
	FInventoryItemChange OnItemRemoved;
	FNoRoomInInventory NoRoomInInventory;

protected:
	virtual void BeginPlay() override;

private:
	TWeakObjectPtr<APlayerController> OwningController;

	void ConstructInventory();

	UPROPERTY()
	TObjectPtr<class UInv_InventoryBase> InventoryMenu;

	UPROPERTY(EditAnywhere, Category="Inventory")
	TSubclassOf<class UInv_InventoryBase> InventoryMenuClass;

	bool bInventoryMenuOpen;
	void OpenInventoryMenu();
	void CloseInventoryMenu();
};
