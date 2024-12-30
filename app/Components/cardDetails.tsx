export default function CardDetails() {
    return <div>
        <div style={{ display: 'flex', flexWrap: 'wrap', gridGap: '50px' }}>
            <div style={{ minWidth: '40%' }}>
                <img />
            </div>
            <div>
                <div>
                    MEN
                </div>
                <div style={{ fontSize: '25px' }}>
                    T_SHIRT 1
                </div>
                <div style={{ fontSize: '20px', fontWeight: 'bold', color: 'rgb(127 118 118)' }}>
                    $33-$35
                </div>
                <div style={{ display: 'flex', flexWrap: 'wrap', gridGap: '10px', marginTop: '10px' }}>
                    <div style={{ height: '20px', width: '20px', background: 'black' }} />
                    <div style={{ height: '20px', width: '20px', background: 'red' }} />
                    <div style={{ height: '20px', width: '20px', background: 'blue' }} />
                </div>
                <div style={{ display: 'flex', flexWrap: 'wrap', gridGap: '10px', marginTop: '10px' }}>
                    <div style={{ height: '20px', width: '20px', border: '1px solid black', display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
                        S
                    </div>
                    <div style={{ height: '20px', width: '20px', border: '1px solid black', display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
                        M
                    </div>
                    <div style={{ height: '20px', width: '20px', border: '1px solid black', display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
                        L
                    </div>
                    <div style={{ height: '20px', width: '20px', border: '1px solid black', display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
                        XL
                    </div>
                    <hr style={{ width: '100%' }} />
                    <div>
                        <input />
                        <button>Add to Cart</button>
                    </div>
                    <hr style={{ width: '100%' }} />
                    <div style={{ display: 'flex', flexWrap: 'wrap', gridGap: '20px' }}>
                        <div>
                            SKU: SKUVALUE
                        </div>
                        <div>
                            Category: WOMEN
                        </div>
                    </div>
                    <hr style={{ width: '100%' }} />
                    <div>
                        Description
                    </div>
                    <hr style={{ width: '100%' }} />
                </div>
            </div>
        </div>
    </div>
}