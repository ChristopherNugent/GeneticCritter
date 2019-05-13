/**
 * The Neighbor enum used for better readabilty when constructing
 * the input for a Critter.
 *
 * These are converted to integers and shifted into a number. It is expected
 * to occupy at most 2 bits. DO NOT modify the number of elements in this enum.
 */
namespace GeneticCritter { 
    
    enum Neighbor { 
        // DO NOT CHANGE THE NUMBER OF ELEMENTS
        SAME,
        ENEMY,
        EMPTY,
        WALL,
        // DO NOT CHANGE THE NUMBER OF ELEMENTS
    }
}