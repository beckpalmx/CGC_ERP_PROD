package com.cgc.Calculator;

public class CostCal {
    double total;
    public double calCost(double cost_value,double weight){
        total = cost_value*weight;
        return total;
    }
    public double calCostWh_Price(double price,double weight){
        total = price/weight;
        return total;
    }
}
