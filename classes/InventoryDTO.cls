public class InventoryDTO {
    @AuraEnabled public Id projectId;
    @AuraEnabled public String projectName;
    @AuraEnabled public List<TowerDTO> towers;
    public class TowerDTO {
        @AuraEnabled public Id towerId;
        @AuraEnabled public String towerName;
        @AuraEnabled public List<FloorDTO> floors;
    }
    public class FloorDTO {
        @AuraEnabled public Integer floorNumber;
        @AuraEnabled public List<UnitDTO> units;
    }
    public class UnitDTO {
        @AuraEnabled public Id unitId;
        @AuraEnabled public String unitNumber;
        @AuraEnabled public String status;
        @AuraEnabled public Decimal sqft;
        @AuraEnabled public Decimal builtupArea;
        @AuraEnabled public Decimal price;
        @AuraEnabled public String facing;
    }

}