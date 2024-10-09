/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package mappingProfiler;

import dto.ProductDTO;
import model.Product;

/**
 * Maps between Product entity and ProductDTO.
 */
public class ProductMapper {

    /**
     * Converts a Product entity to a ProductDTO.
     *
     * @param product the Product entity to convert
     * @return the corresponding ProductDTO or null if the input is null
     */
    public static ProductDTO toDTO(Product product) {
        if (product == null) {
            return null;
        }

        ProductDTO productDTO = new ProductDTO();
        productDTO.setId(product.getProductID()); 
        productDTO.setProductName(product.getProductName());
        productDTO.setPrice(product.getPrice());
        productDTO.setQuantity(product.getQuantity());
        productDTO.setDescription(product.getDescription());

        return productDTO;
    }

    /**
     * Converts a ProductDTO to a Product entity.
     *
     * @param productDTO the ProductDTO to convert
     * @return the corresponding Product entity or null if the input is null
     */
    public static Product toEntity(ProductDTO productDTO) {
        if (productDTO == null) {
            return null;
        }

        Product product = new Product();
        product.setProductID(productDTO.getId()); 
        product.setProductName(productDTO.getProductName());
        product.setPrice(productDTO.getPrice());
        product.setQuantity(productDTO.getQuantity());
        product.setDescription(productDTO.getDescription());

        return product;
    }
}
