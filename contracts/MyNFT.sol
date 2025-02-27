// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


contract MyNFT is ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;

    constructor(address initialOwner) ERC721("Hyver organization", "HORG") Ownable(initialOwner) {}

    function uriConstructor(string memory svgImage) private pure returns (string memory) {
        return string(
            abi.encodePacked(
                "data:image/svg+xml;base64,",
                Base64.encode(bytes(svgImage))
            )
        );
    }

    function jsonConstructor(uint256 tokenId, string memory svgImage) private pure returns (string memory) {

        string memory uri = uriConstructor(svgImage);

        return string(
            abi.encodePacked(
                '{"name": "Hyver organization',
                Strings.toString(tokenId),
                '", "description": "Hyver organization logo", "image": "',
                uri,
                '", "attributes": [{"trait_type": "Style", "value": "Neon"}, {"trait_type": "Background", "value": "Black"}]}'
            )
        );
    }

    function tokenURI( uint256 tokenId) public pure override returns (string memory) {
        string
            memory svgImage = "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1080 1080'><defs><style>.cls-1,.cls-2{fill:#fff;}.cls-2{font-size:150px;font-family:Montserrat-Bold, Montserrat;font-weight:700;letter-spacing:0.07em;}.cls-3{letter-spacing:0.05em;}.cls-4{letter-spacing:0.06em;}</style></defs><g id='Calque_2' data-name='Calque 2'><rect width='1080' height='1080'/><path class='cls-1' d='M480.56,425.26l56.24-60.6-54.24-50.34h-21a35.18,35.18,0,0,0-35.18,35.18V375Z'/><path class='cls-1' d='M626.37,390.32V349.5a35.18,35.18,0,0,0-35.19-35.18h-46.7Z'/><path class='cls-1' d='M569.25,394.78,513,455.38l63.51,58.94h14.66a35.18,35.18,0,0,0,35.19-35.19V447.78Z'/><path class='cls-1' d='M426.37,432.44v46.69a35.18,35.18,0,0,0,35.18,35.19H514.6Z'/><text class='cls-2' transform='translate(242.18 650.65)'>H<tspan class='cls-3' x='132.45' y='0'>Y</tspan><tspan class='cls-4' x='241.35' y='0'>V</tspan><tspan x='362.25' y='0'>ER</tspan></text></g></svg>";

        string memory json = jsonConstructor(
            tokenId, 
            svgImage
        );

        return string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(bytes(json))
                )
            );
    }

    function mint(address _to) external onlyOwner {
        _nextTokenId++;
        _mint(_to, _nextTokenId);
    }
}
