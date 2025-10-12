// Copyright Epic Games, Inc. All Rights Reserved.

#include "Inventory.h"

#define LOCTEXT_NAMESPACE "FInventoryModule"

DEFINE_LOG_CATEGORY(LogInventory);

void FInventoryModule::StartupModule()
{
}

void FInventoryModule::ShutdownModule()
{
}

#undef LOCTEXT_NAMESPACE

IMPLEMENT_MODULE(FInventoryModule, Inventory)
